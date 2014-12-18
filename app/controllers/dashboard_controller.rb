class DashboardController < ApplicationController

  def configuration
	@method = __method__
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @user = User.find_by_id(session["user_id"])
      @user_tier = @user.user_tier
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def monitoring
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @user = User.find_by_id(session["user_id"])
      @user_tier = @user.user_tier
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def points
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @user = User.find_by_id(session["user_id"])
      @user_tier = @user.user_tier
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def green_shop
    puts session["cart"].inspect
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @user = User.find_by_id(session["user_id"])
        
      unless session["cart"]
        session["cart"] = Hash.new
      end
      @user.puntos_vm = 100
      @user.creditos_vm = 100
      @user_tier = @user.user_tier
      @cart = session["cart"]
      @num_items_in_cart = 0
      @cart_total = 0
      @cart.keys.each do |key|
        @num_items_in_cart = @num_items_in_cart + @cart[key]
        @cart_total = @cart_total +  (@cart[key] * Item.find_by_id(key).precio)
      end
      @items = Item.all
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def foundation
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @user = User.find_by_id(session["user_id"])
      @user_tier = @user.user_tier
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def pay_it_forward
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @user = User.find_by_id(session["user_id"])
      @user_tier = @user.user_tier
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def post_fundacion
    if session["user_id"] and User.find_by_id(session["user_id"])
      @user = User.find_by_id(session["user_id"])
      @user_tier = @user.user_tier
      @creditos_vm = params["creditos_vm"]
      @amount = params["amount"]
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def process_payment
    @user = User.find_by_id(session["user_id"])
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    #Stripe.api_key = "sk_test_WsASCDydj4600M6xEyEclCsU"
    Stripe.api_key = "sk_live_oxmNmon9IbVu2xBV3xj2YRAn" #TODO: Set environment variable for this
    puts "params is"
    puts params.inspect
    # Amount in cents
    @amount = params[:amount].to_f * 100

    customer = Stripe::Customer.create(
      :email => @user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Verde Monarca',
      :currency    => 'mxn'
    )
    @user.stripe_id = customer.id
    @user.save()
    puts @user.inspect
    redirect_to(:action=>params[:redirect_action])
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to(:action=>params[:redirect_action])
  end


  def process_donation
    @user = User.find_by_id(session["user_id"])
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    #Stripe.api_key = "sk_test_WsASCDydj4600M6xEyEclCsU"
    Stripe.api_key = "sk_live_oxmNmon9IbVu2xBV3xj2YRAn" #TODO: Set environment variable for this
    puts "params is"
    puts params.inspect
    # Amount in cents
    @amount = (params[:amount].to_f * 100).to_i

    customer = Stripe::Customer.create(
      :email => @user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Verde Monarca',
      :currency    => 'mxn'
    )
    @user.stripe_id = customer.id
    @user.save()
    puts @user.inspect
    redirect_to(:action=>"post_fundacion", :amount => params[:amount], :creditos_vm => params[:creditos_vm])
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to(:action=>"fundacion")
  end

  def process_pay_it_forward
    @user = User.find_by_id(session["user_id"])
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    #Stripe.api_key = "sk_test_WsASCDydj4600M6xEyEclCsU"
    Stripe.api_key = "sk_live_oxmNmon9IbVu2xBV3xj2YRAn" #TODO: Set environment variable for this
    puts "params is"
    puts params.inspect
    # Amount in cents
    @amount = (params[:amount].to_f * 100).to_i

    customer = Stripe::Customer.create(
      :email => @user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Verde Monarca',
      :currency    => 'mxn'
    )
    @user.stripe_id = customer.id
    @user.save()
    puts @user.inspect
    UserMailer.send_donation_confirmation_email(@user, params[:amount], params[:creditos_vm], params[:codigo_vm]).deliver
    redirect_to(:action=>"post_pay_it_forward", :amount => params[:amount], :creditos_vm => params[:creditos_vm], :codigo_vm => params[:codigo_vm], :titular => params[:titular])
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to(:action=>"pay_it_forward")
  end

  def post_pay_it_forward
    if session["user_id"] and User.find_by_id(session["user_id"])
      @user = User.find_by_id(session["user_id"])
      @user_tier = @user.user_tier
      @creditos_vm = params["creditos_vm"]
      @amount = params["amount"]
      @titular = params["titular"]
      @codigo_vm = params["codigo_vm"]
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def item
    @item_id = params["id"]
    @item = Item.find_by_id(@item_id)
    if session["user_id"] and User.find_by_id(session["user_id"])
      @user = User.find_by_id(session["user_id"])
      @user.puntos_vm = 100
      @user.creditos_vm = 100
      @user_tier = @user.user_tier
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def add_to_cart
    cart = session["cart"]
    @item_id = params["item_id"].to_i
    @quantity = params["quantity"].to_i
    unless cart[@item_id]
      cart[@item_id] = 0
    end
    cart[@item_id] = cart[@item_id] + @quantity
    session["cart"] = cart
    puts cart.inspect
    redirect_to(:action => "tienda")
  end

  def carrito
    if session["user_id"] and User.find_by_id(session["user_id"])
      @user = User.find_by_id(session["user_id"])
    else
      redirect_to :action => :index, :controller => :main
    end
    cart = session["cart"]
    @items_and_counts_arr = []
    cart.keys.each do |key|
      @items_and_counts_arr << {'item' => Item.find_by_id(key), 'quantity' => cart[key]}
    end
    @user_tier = @user.user_tier

  end

  #params passed in to this function are {action=>"whatever",controller,=>"whatever", "item1"=>quantity1, .. "itemN" => quantityN}
  def post_carrito
    cart = Hash.new
    puts params.inspect
    params.keys.each do |key|
      if key[0..3]=="item"
        item_id = key.scan(/\d/).join('').to_i
        cart[item_id] = params[key].to_i
      end
    end
    session["cart"] = cart
    puts cart.inspect
    if params["comprar"]
      redirect_to(:action => "comprar")
    else
      redirect_to(:action => "carrito")
    end
  end

  def comprar
    @user = User.find_by_id(session["user_id"])
    @cart = session["cart"]
    @cart_total = 0
    @num_items_in_cart = 0
    @cart.keys.each do |key|
      @num_items_in_cart = @num_items_in_cart + @cart[key]
      @cart_total = @cart_total +  (@cart[key] * Item.find_by_id(key).precio)
    end
  end

  def process_compra
    @user = User.find_by_id(session["user_id"])
    @cart = session["cart"]
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    Stripe.api_key = "sk_test_WsASCDydj4600M6xEyEclCsU"
    # Stripe.api_key = "sk_live_oxmNmon9IbVu2xBV3xj2YRAn" #TODO: Set environment variable for this
    puts "params is"
    puts params.inspect
    # Amount in cents
    @amount = (params[:amount].to_f * 100).to_i

    customer = Stripe::Customer.create(
      :email => @user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Verde Monarca',
      :currency    => 'mxn'
    )
    @user.stripe_id = customer.id
    @user.save()
    puts @user.inspect
    UserMailer.send_purchase_confirmation_email_to_user(@user, @cart).deliver
    UserMailer.send_purchase_confirmation_email_to_admin(@user, @cart).deliver
    redirect_to(:action=>"post_compra")
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to(:action=>"comprar")
  end

  def post_compra
    @user = User.find_by_id(session["user_id"])
    session["cart"] = Hash.new
  end

  def post_change_password
    @user = User.find_by_id(session["user_id"])
    
    if @user.authenticate(params["password_input"])
      if params["password_input_new"]==params["password_input_confirm"]
        @user.password=(params["password_input_new"])
        @user.save()
        render :json =>  { :success => 1, :location => "/dashboard/monitoring"}.to_json
      else
        render :json =>  { :success => 0, :messages => "¡La contrase&ntilde;a no coincide!"}.to_json
      end
    else
      render :json =>  { :success => 0, :messages => "¡la contraseña anterior no coincide!"}.to_json  
    end
  end

  #Configurations Methods
  def users
	redirect_to(:action=>"index", :controller => "user")
  end
  
  def profiles
	redirect_to(:action=>"index", :controller => "profile")
  end
  
  def pages
	redirect_to(:action=>"index", :controller => "page")
  end
  
  def permissions
	redirect_to(:action=>"index", :controller => "permission")
  end
  
  def countries
	redirect_to(:action=>"index", :controller => "country")
  end
  
  def states
	redirect_to(:action=>"index", :controller => "state")
  end
  
  def locations
	redirect_to(:action=>"index", :controller => "location")
  end
  
end
