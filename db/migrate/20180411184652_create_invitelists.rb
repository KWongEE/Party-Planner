class CreateInvitelists < ActiveRecord::Migration[5.2]
  def change
    create_table :invite_lists do |t|
      t.belongs_to :party
      t.belongs_to :friend

      t.timestamps null: false
    end
  end
end
