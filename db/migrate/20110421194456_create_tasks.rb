class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.references :list, :null =>false
      t.string :title, :null =>false, :limit =>200
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
