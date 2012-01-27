class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
	t.column :title,		:string
	t.column :brief,		:text
	t.column :content,		:text
	t.column :raw_content,		:text
	t.column :cached_tag_list,	:text
	t.column :package_data,		:text
	t.column :created_at,		:datetime
	t.column :updated_at,		:datetime
	t.column :read_count,		:integer
	t.column :bit_opt,		:integer, :default => 0
	t.column :user_id,		:integer, :null => false
	t.column :category_id,		:integer
    end
  end

  def down
    drop_table :articles
  end
end
