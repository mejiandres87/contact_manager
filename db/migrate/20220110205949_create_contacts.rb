class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.date :birthdate
      t.string :phone_number
      t.string :address
      t.string :cc_mask
      t.string :hashed_cc
      t.string :cc_franchise
      t.string :email
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
