class HomeController < ApplicationController
  respond_to :html, :xml, :json

  def index
    if current_user
      @lists = List.lists_by_user current_user.id
    end
  end

end
