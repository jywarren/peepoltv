class AddLocation < ActiveRecord::Migration
  def self.up
    add_column :videos, :location, :string, :default => "", :null => false 
  end

  def self.down
    remove_column :videos, :location
  end
end
