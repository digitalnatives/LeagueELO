ActiveAdmin.register Match do
  permit_params :status, :team_a_avg_point, :team_b_avg_point

  form do |f|
    f.input :player, as: :select2
  end

  form do |f|
    f.inputs "Player" do
      f.has_many :players, allow_destroy: true, new_record: "Add Player" do |e|
        e.input :player, as: :select2_multiple
      end
    end
  end
end
