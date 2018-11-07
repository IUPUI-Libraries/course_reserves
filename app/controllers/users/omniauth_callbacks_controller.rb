class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  respond_to :html, :json

  def cas
    @user = User.from_iucas(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "IUCAS")
    else
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end
