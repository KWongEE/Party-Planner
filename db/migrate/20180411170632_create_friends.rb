class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps null: false
    end
  end
end
