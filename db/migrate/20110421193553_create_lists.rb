class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.string :name, :null =>false, :limit =>200
      t.boolean :public, :null =>false, :default =>true
      t.timestamps
    end
  end

  def self.down
    drop_table :lists
  end
end
