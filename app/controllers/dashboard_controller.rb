class DashboardController < ApplicationController

  def configuration
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @online_user = User.find_by_id(session["user_id"])
      @user_tier = @online_user.user_tier
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def monitoring
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @online_user = User.find_by_id(session["user_id"])
      @user_tier = @online_user.user_tier
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def points
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @online_user = User.find_by_id(session["user_id"])
      @user_tier = @online_user.user_tier
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def green_shop
    puts session["cart"].inspect
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @online_user = User.find_by_id(session["user_id"])
        
      unless session["cart"]
        session["cart"] = Hash.new
      end
      @user_tier = @online_user.user_tier
      @cart = session["cart"]
      @num_items_in_cart = 0
      @cart_total = 0
      @cart.keys.each do |key|
        @num_items_in_cart = @num_items_in_cart + @cart[key]
        @cart_total = @cart_total +  (@cart[key] * ProductSize.find_by_id(key).price)
      end
      @items_category1 = Item.all.where(active: true, category_id:1)
      @items_category2 = Item.all.where(active: true, category_id:2)
      @items_category3 = Item.all.where(active: true, category_id:3)
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def foundation
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @online_user = User.find_by_id(session["user_id"])
      @user_tier = @online_user.user_tier
	  @country = Country.find_by_id(@online_user.country_id)
	  @state = State.find_by_id(@online_user.state_id)
	  @location = Location.find_by_id(@online_user.location_id)
	  @signatureDavid = Base64.encode64(File.open("app/assets/customerSignature/signatureDavid.png", "rb").read)
	  @logo_verde_monarca = Base64.encode64(File.open("app/assets/images/Logo_Verde_Monarca.png", "rb").read)
	  
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def pay_it_forward
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @online_user = User.find_by_id(session["user_id"])
      @user_tier = @online_user.user_tier
	  @country = Country.find_by_id(@online_user.country_id)
	  @state = State.find_by_id(@online_user.state_id)
	  @location = Location.find_by_id(@online_user.location_id)
	  @signatureDavid = Base64.encode64(File.open("app/assets/customerSignature/signatureDavid.png", "rb").read)
	  @logo_verde_monarca = Base64.encode64(File.open("app/assets/images/Logo_Verde_Monarca.png", "rb").read)
	  @projects = Project.where(project_type_id: 2, active: true)
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def check_credits
	@online_user = User.find_by_id(session["user_id"])
	credit = params["pCredit"]
	amount = params["pAmount"]
	if credit == "" and amount == ""
      render :json =>  { :success => 0, :messages => "¡Debes especificar la cantidad de donación!"}.to_json
	elsif amount > "0" and amount < "10"
      render :json =>  { :success => 0, :messages => "¡La cantidad en efectivo debe de ser mayor de $10!"}.to_json
	else
		if credit.to_i > @online_user.creditos_vm.to_i
		  render :json =>  { :success => 0, :messages => "¡No tienes los suficientes creditos para donar!"}.to_json  
		else
		  render :json =>  { :success => 1, :messages => "" }.to_json  
		end 
	end
  end
  
  def process_donation
    @online_user = User.find_by_id(session["user_id"])
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    Stripe.api_key = @stripe_sk_test
    puts "params is"
    puts params.inspect
    # Amount in cents
	@amount = 0
	@customer_id = ""
	if params[:amount] != "0"
		@amount = (params[:amount].to_f * 100).to_i
		customer = Stripe::Customer.create(
		  :email => @online_user.email,
		  :card  => params[:stripeToken]
		)

		charge = Stripe::Charge.create(
		  :customer    => customer.id,
		  :amount      => @amount,
		  :description => 'Verde Monarca',
		  :currency    => 'mxn'
		)
		@customer_id = customer.id
	end

    @online_user.stripe_id = @customer_id
	@online_user.creditos_vm = @online_user.creditos_vm.to_i - params[:creditos_vm].to_i
    @online_user.save()
    puts @online_user.inspect
	
	donation_serie = DonationHistory.find_by_sql("SELECT id FROM donation_histories WHERE user_id=" + @online_user.id.to_s + " AND donation_type_id=1")
	serie = (donation_serie.count + 1).to_s
	serie = serie.rjust(3, '0')
	
	contractPDF = params["contract"]
	contract = @online_user.id.to_s + "-" + @online_user.clave_referencia + "-Contrato_Donación_Fundación_VM-" + serie
	File.open('app/assets/contracts/' + contract + '.pdf',"wb") do |file|
		file.write(Base64.decode64(contractPDF))
	end
	
	donation_history = DonationHistory.new
	donation_history.description = "Generado por sistema"
	donation_history.user_id = @online_user.id
	donation_history.donation_type_id = 1
	donation_history.project_id  = params["project_id"]
	donation_history.amount_mxn = @amount
	donation_history.credit_vm = params["creditos_vm"]
	donation_history.contract_file_name = contract
	donation_history.active = true
	donation_history.save()
	
    UserMailer.send_donation_confirmation_email_to_admin(@online_user, params[:amount], params[:creditos_vm], '¡Agua Para Todos!', 1).deliver
    UserMailer.send_donation_confirmation_email_to_user(@online_user, params[:amount], params[:creditos_vm], '¡Agua Para Todos!', 1).deliver
    redirect_to(:action=>"post_fundacion", :amount => params[:amount], :creditos_vm => params[:creditos_vm])
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to(:action=>"foundation")
  end

  def post_fundacion
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @online_user = User.find_by_id(session["user_id"])
      @user_tier = @online_user.user_tier
      @creditos_vm = params["creditos_vm"]
      @amount = params["amount"]
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def process_payment
    @online_user = User.find_by_id(session["user_id"])
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    Stripe.api_key = "sk_test_WsASCDydj4600M6xEyEclCsU"
    #Stripe.api_key = "sk_live_oxmNmon9IbVu2xBV3xj2YRAn" #TODO: Set environment variable for this
    puts "params is"
    puts params.inspect
    # Amount in cents
    @amount = params[:amount].to_f * 100

    customer = Stripe::Customer.create(
      :email => @online_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Verde Monarca',
      :currency    => 'mxn'
    )
    @online_user.stripe_id = customer.id
    @online_user.save()
    puts @online_user.inspect
    redirect_to(:action=>params[:redirect_action])
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to(:action=>params[:redirect_action])
  end


  def process_pay_it_forward
    @online_user = User.find_by_id(session["user_id"])
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    Stripe.api_key = @stripe_sk_test
    puts "params is"
    puts params.inspect
    # Amount in cents
	@amount = 0
	@customer_id = ""
	if params[:amount] != "0"
		@amount = (params[:amount].to_f * 100).to_i
		customer = Stripe::Customer.create(
		  :email => @online_user.email,
		  :card  => params[:stripeToken]
		)

		charge = Stripe::Charge.create(
		  :customer    => customer.id,
		  :amount      => @amount,
		  :description => 'Verde Monarca',
		  :currency    => 'mxn'
		)
		@customer_id = customer.id
	end

    @online_user.stripe_id = @customer_id
	@online_user.creditos_vm = @online_user.creditos_vm.to_i - params[:creditos_vm].to_i
    @online_user.save()
    puts @online_user.inspect
	
	@donation_type = params["donation_type"].to_s
	contractPDF = params["contract"]
	@contract = ""
	if @donation_type == "2"
	
		donation_serie = DonationHistory.find_by_sql("SELECT id FROM donation_histories WHERE user_id=" + @online_user.id.to_s + " AND donation_type_id=2")
		serie = (donation_serie.count + 1).to_s
		serie = serie.rjust(3, '0')
		
		@contract = @online_user.id.to_s + "-" + @online_user.clave_referencia + "-Contrato_Donación_Entre_Usuarios-" + serie
	elsif @donation_type == "3"
	
		donation_serie = DonationHistory.find_by_sql("SELECT id FROM donation_histories WHERE user_id=" + @online_user.id.to_s + " AND donation_type_id=3")
		serie = (donation_serie.count + 1).to_s
		serie = serie.rjust(3, '0')
		
		@contract = @online_user.id.to_s + "-" + @online_user.clave_referencia + "-Contrato_Inversión_Entre_Usuarios-" + serie
	end
	File.open('app/assets/contracts/' + @contract + '.pdf',"wb") do |file|
		file.write(Base64.decode64(contractPDF))
	end
	
	donation_history = DonationHistory.new
	donation_history.description = "Generado por sistema"
	donation_history.user_id = @online_user.id
	donation_history.donation_type_id = @donation_type
	donation_history.project_id  = params["project_id"]
	donation_history.amount_mxn = @amount
	donation_history.credit_vm = params["creditos_vm"]
	donation_history.contract_file_name = @contract
	donation_history.active = true
	donation_history.save()
	
    UserMailer.send_donation_confirmation_email_to_admin(@online_user, params[:amount], params[:creditos_vm], params[:codigo_vm], @donation_type).deliver
    UserMailer.send_donation_confirmation_email_to_user(@online_user, params[:amount], params[:creditos_vm], params[:codigo_vm], @donation_type).deliver
    redirect_to(:action=>"post_pay_it_forward", :amount => params[:amount], :creditos_vm => params[:creditos_vm], :codigo_vm => params[:codigo_vm], :titular => params[:titular], :donation_type => @donation_type)
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to(:action=>"pay_it_forward")
  end

  def post_pay_it_forward
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @online_user = User.find_by_id(session["user_id"])
      @online_user = User.find_by_id(session["user_id"])
      @user_tier = @online_user.user_tier
      @creditos_vm = params["creditos_vm"]
      @amount = params["amount"]
      @titular = params["titular"]
      @codigo_vm = params["codigo_vm"]
      @donation_type = params["donation_type"].to_s
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def item
    @item_id = params["id"]
    @item = Item.find_by_id(@item_id)
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @online_user = User.find_by_id(session["user_id"])
      @user_tier = @online_user.user_tier
	  @product_size = ProductSize.where(active: true, item_id: @item_id)
      @cart = session["cart"]
      @num_items_in_cart = 0
      @cart_total = 0
      @cart.keys.each do |key|
        @num_items_in_cart = @num_items_in_cart + @cart[key]
        @cart_total = @cart_total +  (@cart[key] * ProductSize.find_by_id(key).price)
      end
    else
      redirect_to :action => :index, :controller => :main
    end
  end

  def add_to_cart
    cart = session["cart"]
    @item_id = params["product_size_id"].to_i
    @quantity = params["quantity"].to_i
    unless cart[@item_id]
      cart[@item_id] = 0
    end
    cart[@item_id] = cart[@item_id] + @quantity
    session["cart"] = cart
    puts cart.inspect
    redirect_to(:action => "green_shop")
  end

  def carrito
    if session["user_id"] and User.find_by_id(session["user_id"])
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @online_user = User.find_by_id(session["user_id"])
    else
      redirect_to :action => :index, :controller => :main
    end
    cart = session["cart"]
    @items_and_counts_arr = []
    cart.keys.each do |key|
      @items_and_counts_arr << {'item' => Item.find_by_id(key), 'quantity' => cart[key]}
    end
    @user_tier = @online_user.user_tier

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
    @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
    @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
    @online_user = User.find_by_id(session["user_id"])
	@location = Location.find_by_id(@online_user.location_id)
	@state = State.find_by_id(@location.state_id)
    @cart = session["cart"]
    @cart_total = 0
    @num_items_in_cart = 0
    @cart.keys.each do |key|
      @num_items_in_cart = @num_items_in_cart + @cart[key]
      @cart_total = @cart_total +  (@cart[key] * Item.find_by_id(key).precio)
    end
  end

  def process_compra
    @online_user = User.find_by_id(session["user_id"])
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
      :email => @online_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Verde Monarca',
      :currency    => 'mxn'
    )
    @online_user.stripe_id = customer.id
    @online_user.save()
    puts @online_user.inspect
    UserMailer.send_purchase_confirmation_email_to_user(@online_user, @cart).deliver
    UserMailer.send_purchase_confirmation_email_to_admin(@online_user, @cart).deliver
    redirect_to(:action=>"post_compra")
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to(:action=>"comprar")
  end

  def post_compra
    @online_user = User.find_by_id(session["user_id"])
    session["cart"] = Hash.new
  end

  def post_change_password
    @online_user = User.find_by_id(session["user_id"])
    
    if @online_user.authenticate(params["password_input"])
      if params["password_input_new"]==params["password_input_confirm"]
        @online_user.password=(params["password_input_new"])
        @online_user.save()
        render :json =>  { :success => 1, :location => "/dashboard/monitoring"}.to_json
      else
        render :json =>  { :success => 0, :messages => "¡La contrase&ntilde;a no coincide!"}.to_json
      end
    else
      render :json =>  { :success => 0, :messages => "¡la contraseña anterior no coincide!"}.to_json  
    end
  end
  
  def myContract
    if session["user_id"] and User.find_by_id(session["user_id"])
	  if SecurityController.has_permission(session[:user_id], "myContract") == false
		redirect_to :action => :monitoring, :controller => :dashboard
	  end
	  @pages = Page.select("description, command").where(menu_id: 1, active: true).order(order_by: :asc)
	  @configurations = Page.select("description, command").where(menu_id: 2, active: true).order(order_by: :asc)
      @online_user = User.find_by_id(session["user_id"])
      @user_tier = @online_user.user_tier
	  
	  sql = "SELECT dh.id, dh.active, dh.description, dh.amount_mxn, dh.credit_vm, dh.contract_file_name, us.nombre, us.apellido, pj.description as project, dt.description as donation_type FROM donation_histories dh LEFT JOIN users us ON dh.user_id = us.id LEFT JOIN donation_types dt ON dh.donation_type_id = dt.id LEFT JOIN projects pj ON dh.project_id = pj.id"
	  @dh = DonationHistory.find_by_sql(sql)
	else
	  redirect_to :action => :index, :controller => :main
	end
  end 
end
