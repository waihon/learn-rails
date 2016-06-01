class ContactsController < ApplicationController

  # def process_form
  #   Rails.logger.debug "DEBUG: params are #{params}"
  #   flash[:notice] = "Received reequest from #{params[:contact][:name]}"
  #   redirect_to root_path
  # end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(secure_params)
    if @contact.valid?
      UserMailer.contact_email(@contact).deliver_now
      flash[:notice] = "Message sent from #{@contact.name}."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def secure_params
    params.require(:contact).permit(:name, :email, :content)
  end

end