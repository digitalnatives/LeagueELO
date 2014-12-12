class Match < ActiveRecord::Base
  has_many :match_players
  has_many :players, through: :match_players

  has_many :team_a_match_players, -> { where(team: 'A') }, class_name: 'MatchPlayer'
  has_many :team_b_match_players, -> { where(team: 'B') }, class_name: 'MatchPlayer'
  has_many :team_a_players, through: :team_a_match_players, class_name: 'Player', source: :player
  has_many :team_b_players, through: :team_b_match_players, class_name: 'Player', source: :player
end
