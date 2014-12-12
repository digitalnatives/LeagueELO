class Player < ActiveRecord::Base
  has_many :match_players
  has_many :matches, through: :match_players
  validates_presence_of :name

  attr_reader :win_count, :defeat_count

  def position
    Player.order('point DESC').pluck(:id).index { |player_id| player_id == self.id } + 1
  end

  def count_results!
    @win_count = 0
    @defeat_count = 0
    matches.closed.each do |match|
      if match.team_a_players.include? self
        if match.score_a > match.score_b
          @win_count += 1
        else
          @defeat_count += 1
        end
      else
        if match.score_a > match.score_b
          @defeat_count += 1
        else
          @win_count += 1
        end
      end
    end
  end
end
