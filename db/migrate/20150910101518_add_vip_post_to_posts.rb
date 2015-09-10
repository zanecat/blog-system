class AddVipPostToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :vip_post, :boolean, default: false
  end
end
