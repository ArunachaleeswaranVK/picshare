class AddImageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :url , :string
    add_column :posts, :image_name , :string
  end
end
