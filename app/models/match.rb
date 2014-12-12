class Match < ActiveRecord::Base
  has_many :match_players
  has_many :players, through: :match_players

  has_many :team_a_match_players, -> { where(team: 'A') }, class_name: 'MatchPlayer'
  has_many :team_b_match_players, -> { where(team: 'B') }, class_name: 'MatchPlayer'
  has_many :team_a_players, through: :team_a_match_players, class_name: 'Player', source: :player
  has_many :team_b_players, through: :team_b_match_players, class_name: 'Player', source: :player

  def close!
    transaction do
      store_points_on_join!
      recalculate_averages
      update_player_points!
      self.status = 'closed'
      save!
    end
  end

  def closed?
    status == 'closed'
  end

  private

  def recalculate_averages
    a_points = team_a_players.map(&:point)
    self.team_a_avg_point = a_points.sum.to_f / a_points.size
    b_points = team_a_players.map(&:point)
    self.team_b_avg_point = b_points.sum.to_f / b_points.size
  end

  def calculator
    @calculator ||= EloCalculator.new(team_a_avg_point, team_b_avg_point, score_a, score_b, draws)
  end

  def update_player_points!
    d = calculator.delta
    team_a_players.each do |player|
      player.update_attribute(:point, player.point + d)
    end
    team_b_players.each do |player|
      player.update_attribute(:point, player.point - d)
    end
  end

  def store_points_on_join!
    match_players.each do |mp|
      mp.update_attribute(:current_point, mp.player.point)
    end
  end
end
