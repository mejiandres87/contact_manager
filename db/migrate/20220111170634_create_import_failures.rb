class CreateImportFailures < ActiveRecord::Migration[6.1]
  def change
    create_table :import_failures do |t|
      t.string :file_line
      t.string :failure_messages
      t.references :contacts_file, null: false, foreign_key: true

      t.timestamps
    end
  end
end
