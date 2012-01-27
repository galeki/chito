class AddCommentIp < ActiveRecord::Migration
  def up
    add_column :comments, :ip, :string
  end

  def down
    remove_column :comments, :ip
  end
end
