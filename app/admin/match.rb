ActiveAdmin.register Match do
  permit_params :score_a, :score_b, :draws, team_a_player_ids: [], team_b_player_ids: []

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Match" do
      f.input :team_a_player_ids, label: 'Team A', as: :select2, collection: Player.all, input_html: { multiple: true }
      f.input :team_b_player_ids, label: 'Team B', as: :select2, collection: Player.all, input_html: { multiple: true }

      f.input :score_a
      f.input :score_b
      f.input :draws
    end

    f.actions
  end

  member_action :close do
    match = Match.find(params[:id])

    match.close!

    redirect_to action: :show, notice: 'Match closed.'
  end

  action_item only: :show do
    link_to 'Close', close_admin_match_path(match) if match.can_close?
  end

end
