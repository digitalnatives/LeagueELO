class AddNicknameToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :nickname, :string, index: true
  end
end
