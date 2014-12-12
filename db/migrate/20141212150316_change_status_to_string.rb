class ChangeStatusToString < ActiveRecord::Migration
  def change
    change_column :matches, :status, :string
    add_column :matches, :score_a, :integer, default: 0
    add_column :matches, :score_b, :integer, default: 0
    add_column :matches, :drawns, :integer, default: 0
  end
end
