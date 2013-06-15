class SignupController < ApplicationController
  def business
  end

  def user
  end

  def submit_user
    @user = params[:user]
  end

end
