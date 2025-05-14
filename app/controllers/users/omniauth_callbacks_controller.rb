class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in @user
      redirect_to recipes_look_path
      set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
    else
      redirect_to new_user_registration_path
      flash[:alert] = @user.errors.full_messages.to_sentence
    end
  end

  def failure
    redirect_to root_path and return
  end
end
