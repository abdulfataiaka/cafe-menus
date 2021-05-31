class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.string  :name
      t.string  :price
      t.string  :photo
      t.integer :type

      t.timestamps
    end
  end
end
