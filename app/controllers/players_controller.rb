class PlayersController < ApplicationController
  def index
    @players = Player.order('point DESC')
    @matches = Match.closed.order('created_at DESC').limit(10)
  end

  def show
    @player = Player.find(params[:id])
    @player.count_results!
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.create(player_params)

    if @player.valid?
      redirect_to root_path
    else
      render action: :new
    end
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
