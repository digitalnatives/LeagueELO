class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.float :team_a_avg_point
      t.float :team_b_avg_point
      t.text :status

      t.timestamps
    end
  end
end
