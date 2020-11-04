class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.string :image, :default =>  "https://www.monsterchildren.com/wp-content/uploads/2020/02/nic-cage-monster-children-1068x571.jpg"
      #Ex:- :default =>''
      t.boolean :active?, default: true
      t.integer :inventory
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
