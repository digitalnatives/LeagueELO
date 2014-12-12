module MatchesHelper

  def players_for_select
    Player.all.map { |p| [p.name, p.id] }
  end
end
