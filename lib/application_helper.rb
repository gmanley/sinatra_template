module ApplicationHelper
  #Authentication Helpers
  
  def logged_in?
    !session[:user].nil?
  end

  #Error Helpers

  def flash(msg)
    session[:flash] = msg
  end

  def show_flash
    if session[:flash]
      tmp = session[:flash]
      session[:flash] = false
      "<div>#{tmp}</div>"
    end
  end

end
