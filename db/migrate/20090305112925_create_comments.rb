class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :author, :author_url, :author_email
      t.text :description
      t.boolean :spam, :default => false
      t.boolean :status, :default => false
      t.references :commentable, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
