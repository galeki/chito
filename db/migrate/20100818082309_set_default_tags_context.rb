class SetDefaultTagsContext < ActiveRecord::Migration
  def self.up
    execute "update `taggings` set context = \"tags\""
  end

  def self.down
    execute "update `taggings` set context = NULL"
  end
end
