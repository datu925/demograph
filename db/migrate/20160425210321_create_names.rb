class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :name, null: false
      t.string :gender
      t.decimal :probability
      t.integer :count
      t.timestamps(null: false)
      t.index :name, unique: true
    end
  end
end
