class AddUserIdToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :user_id, :integer
  end
end
