class CreateMatchPlayers < ActiveRecord::Migration
  def change
    create_table :match_players do |t|
      t.belongs_to :player
      t.belongs_to :match
      t.string :team
      t.float :current_point

      t.timestamps
    end
  end
end
