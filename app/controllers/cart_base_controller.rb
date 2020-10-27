class CartBaseController < ApplicationController
  before_action :require_non_admin

  def require_non_admin
    render file: "/public/404" if current_admin?
  end
end