class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = User.new
    if current_user
      redirect_to doctors_path
    end
  end

  def search
  end
end
