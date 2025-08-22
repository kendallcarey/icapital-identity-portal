class HomeController < ApplicationController
  def redirect
    if authenticated?
      redirect_to investors_path
    else
      redirect_to new_session_path
    end
  end
end
