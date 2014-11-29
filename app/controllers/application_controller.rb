class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :common_content
  def common_content
    #TODO: Configure Stripe keys in environment
    @stripe_pk_test = "pk_test_KKPPZQWQUL4ygPop5p6QCrz5"
    @stripe_sk_test = "sk_test_WsASCDydj4600M6xEyEclCsU"
    @stripe_pk_live = "pk_live_TZMVzigJsplccEBJVDYNjcGQ"
    @stripe_sk_live = "sk_live_oxmNmon9IbVu2xBV3xj2YRAn"
    @color_classes = { "Bronce" => "bronze-color", "Plata" => "silver-color", "Oro" => "gold-color", "Platino" => "platinum-color", "Verde" => "theme-color"}
  end
end
