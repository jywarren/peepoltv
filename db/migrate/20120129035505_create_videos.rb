class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :title, :default => '', :null => false
      t.string :author, :default => 'anonymous', :null => false
      t.string :embedcode, :default => '', :null => false
      t.float :latitude, :default => 0, :null => false, :precision => 20
      t.float :longitude, :default => 0, :null => false, :precision => 20
      t.timestamps
    end
    create_table :tags do |t|
      t.string :name, :default => '', :null => false
      t.integer :video_id, :default => 0, :null => false
    end
  end

  def self.down
    drop_table :videos
    drop_table :tags
  end
end
