class CreateMenuItems < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_items do |t|
      t.string  :name
      t.string  :price
      t.string  :photo
      t.string :type

      t.timestamps
    end
  end
end
