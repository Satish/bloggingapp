class CreateTinyMcePhotos < ActiveRecord::Migration
  def self.up
    create_table :tiny_mce_photos do |t|
      t.string        :name, :content_type, :filename, :thumbnail
      t.text          :description
      t.references     :user, :parent
      t.integer        :size, :width, :height

      t.timestamps
    end
  end

  def self.down
    drop_table :tiny_mce_photos
  end
end