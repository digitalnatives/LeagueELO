class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.float :point, default: 2000

      t.timestamps
    end
  end
end
