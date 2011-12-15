class AddAncestryToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :ancestry, :string
    add_index :codes, :ancestry
  end
end
