module UsersHelper
  def user_signed_in?
    !session[:user_id].nil?
  end
end
