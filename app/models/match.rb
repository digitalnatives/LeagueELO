class Match < ActiveRecord::Base
  has_many :match_players
  has_many :players, through: :match_players
end
