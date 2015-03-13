class Match < ActiveRecord::Base
  has_many :match_players
  has_many :players, through: :match_players, dependent: :destroy

  has_many :team_a_match_players, -> { where(team: 'A') }, class_name: 'MatchPlayer'
  has_many :team_b_match_players, -> { where(team: 'B') }, class_name: 'MatchPlayer'
  has_many :team_a_players, through: :team_a_match_players, class_name: 'Player', source: :player
  has_many :team_b_players, through: :team_b_match_players, class_name: 'Player', source: :player

  validate :validate_player_uniqueness
  validates :score_a, :score_b, :draws, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :team_a_players, presence: true
  validates :team_b_players, presence: true

  attr_accessor :team_a_player_names, :team_b_player_names
  before_validation :generate_player_ids

  scope :closed, -> { where(status: 'closed') }

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

  def can_close?
    has_score? && !closed?
  end

  def has_score?
    score_a + score_b + draws > 0
  end

  private

  def validate_player_uniqueness
    unless player_ids.size == player_ids.uniq.size
      errors.add :players, 'should be unique across teams.'
    end
  end

  def recalculate_averages
    a_points = team_a_players.map(&:point)
    self.team_a_avg_point = a_points.sum.to_f / a_points.size
    b_points = team_b_players.map(&:point)
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

  def generate_player_ids
    %i(a b).each do |team_name|
      if (player_names = public_send(:"team_#{team_name}_player_names")).present?
        ids = player_names.split(' ').map do |player_name|
          Player.find_by_nick_or_name(player_name).try(:id)
        end
        public_send(:"team_#{team_name}_player_ids=", ids)
      end
    end
  end

end
