module ApplicationHelper
  #Authentication Helpers
  
  def logged_in?
    !session[:user].nil?
  end

end
