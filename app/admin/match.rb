ActiveAdmin.register Match do
  permit_params :status, :team_a_avg_point, :team_b_avg_point
end
