class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({"email" => params["email"]})
    if @user
        if BCrypt::Password.new(@user["password"]) == params["password"]
            session["user_id"] = @user["id"]
            flash["notice"] = "Welcome."
            redirect_to "/"
        else 
            flash["notice"] = "Wrong password."
            redirect_to "/login"
        end
    else
        flash["notice"] = "Wrong email."
        redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "See you next time!"
    redirect_to "/login"
  end
end
  