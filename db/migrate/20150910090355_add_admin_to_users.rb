class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :enterprise, :boolean, default: false
  end
end
