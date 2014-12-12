class PlayersController < ApplicationController
  def index
    @players = Player.order('point DESC')
    @matches = Match.closed.order('created_at DESC').limit(10)
  end

  def show
    @player = Player.find(params[:id])
    @player.count_results!
  end
end
