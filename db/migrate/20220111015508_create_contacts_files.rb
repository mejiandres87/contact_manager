class CreateContactsFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts_files do |t|
      t.string :name
      t.integer :imports
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
