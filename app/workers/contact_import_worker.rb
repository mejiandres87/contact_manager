require 'csv'

class ContactImportWorker
  include Sidekiq::Worker

  def perform(contacts_file_id)
    contacts_file = ContactsFile.find_by(id: contacts_file_id)
    if contacts_file.pending?
      contacts_file.processing!
      CSV.parse(contacts_file.csv_file.download, headers: true, encoding: 'UTF-8') do |file_line|
        new_contact = Contact.new(file_line.to_h)
        new_contact.user_id = contacts_file.user_id
        if new_contact.save 
          contacts_file.imports += 1
        else
          contacts_file.import_failures.build(file_line: file_line.to_s, failure_messages: new_contact.errors.full_messages.join("\n"))
        end
        rescue ActiveModel::UnknownAttributeError => e 
          contacts_file.import_failures.build(file_line: file_line.to_s, failure_messages: e.message)
          next
      end
      if contacts_file.imports == 0
        contacts_file.failed!
      else
        contacts_file.finished!
      end
    end
  end
end
