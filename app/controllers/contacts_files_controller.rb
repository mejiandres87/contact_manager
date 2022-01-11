class ContactsFilesController < ApplicationController
  def index
    @contacts_file = ContactsFile.new
    @contacts_files = current_user.contacts_files.paginate(page: params[:page], per_page: 10)
  end

  def show
    @contacts_file = current_user.contacts_files.find_by(id: params[:id])
    redirect_to contacts_files_url if @contacts_file.nil?
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

  private
  def contacts_file_params
    params.require(:contacts_file).permit(:csv_file)
  end
end
