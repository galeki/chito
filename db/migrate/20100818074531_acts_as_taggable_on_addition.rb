class ActsAsTaggableOnAddition < ActiveRecord::Migration
  def self.up
    add_column :taggings, :tagger_id, :integer
    add_column :taggings, :tagger_type, :string
    add_column :taggings, :context, :string

    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end

  def self.down
    remove_column :taggings, :tagger_id
    remove_column :taggings, :tagger_type
    remove_column :taggings, :context
    remove_index :taggings, [:taggable_id, :taggable_type]
  end
end
