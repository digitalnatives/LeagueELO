class MatchesController < ApplicationController
  def new
    @match = Match.new
  end

  def create
    respond_to do |format|
      format.html do
        @match = Match.create(match_params)

        if @match.valid?
          @match.close!
          redirect_to root_path
        else
          render action: :new
        end
      end
      format.js do
        @match = Match.create(match_params)
        @match.close! if @match.valid?
        render json: @match
      end
    end
  end

  def match_params
    params.require(:match).permit(
      :score_a,
      :score_b,
      :draws,
      team_a_player_names: [],
      team_b_player_names: [],
      team_a_player_ids: [],
      team_b_player_ids: []
    )
  end
end
