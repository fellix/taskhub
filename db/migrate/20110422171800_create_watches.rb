class CreateWatches < ActiveRecord::Migration
  def self.up
    create_table :watches do |t|
      t.references :user, :null => false
      t.references :list, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :watches
  end
end
