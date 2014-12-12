class MatchesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.create(match_params)

    if @match.valid?
      @match.close!
      redirect_to root_path 
    else
      render action: :new
    end
  end

  def match_params
    params.require(:match).permit(
      :score_a,
      :score_b,
      :team_a_player_ids => [],
      :team_b_player_ids => []
    )
  end
  
end
