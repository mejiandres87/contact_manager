require 'csv'

class ContactsFilesController < ApplicationController
  before_action :set_contacts_file, only: [:show, :import_contacts_from_file]
  def index
    @contacts_file = ContactsFile.new
    @contacts_files = current_user.contacts_files.paginate(page: params[:page], per_page: 5)
  end

  def show
    
  end

  def create
    params_hash = contacts_file_params
    @contacts_file = ContactsFile.new(params_hash)
    @contacts_file.user = current_user
    @contacts_file.name = params_hash.to_h[:csv_file].original_filename
    if(@contacts_file.save)
      redirect_to @contacts_file
    else 
      render :index
    end
  end

  def import_contacts_from_file
    if @contacts_file.pending?
      @contacts_file.processing!
      CSV.parse(@contacts_file.csv_file.download, headers: true, encoding: 'UTF-8') do |file_line|
        new_contact = current_user.contacts.build(file_line.to_h)
        if new_contact.save 
          @contacts_file.imports += 1
        else
          @contacts_file.import_failures.build(file_line: file_line.to_s, failure_messages: new_contact.errors.full_messages.join("\n"))
        end
        rescue ActiveModel::UnknownAttributeError => e 
          @contacts_file.import_failures.build(file_line: file_line.to_s, failure_messages: e.message)
          next
      end
      if @contacts_file.imports == 0
        @contacts_file.failed!
      else
        @contacts_file.finished!
      end
    end
    redirect_to @contacts_file
  end

  private
  def contacts_file_params
    params.require(:contacts_file).permit(:csv_file)
  end

  def set_contacts_file
    @contacts_file = current_user.contacts_files.find_by(id: params[:id])
    redirect_to contacts_files_url if @contacts_file.nil?
  end
end
