class ChangeNameDrawnsToDrawsInMatches < ActiveRecord::Migration
  def change
    rename_column :matches, :drawns, :draws
  end
end
