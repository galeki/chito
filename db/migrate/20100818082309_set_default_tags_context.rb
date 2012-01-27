class SetDefaultTagsContext < ActiveRecord::Migration
  def up
    execute "update `taggings` set context = \"tags\""
  end

  def down
    execute "update `taggings` set context = NULL"
  end
end
