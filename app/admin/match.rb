ActiveAdmin.register Match do
  permit_params :status, team_a_player_ids: [], team_b_player_ids: []

  form do |f|
    f.inputs "Match" do
      f.input :status

      f.input :team_a_player_ids, label: 'Team A', as: :select2, collection: Player.all, input_html: { multiple: true }
      f.input :team_b_player_ids, label: 'Team B', as: :select2, collection: Player.all, input_html: { multiple: true }
    end

    f.actions
  end
end
