class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :users, :username, :user
  end
end
