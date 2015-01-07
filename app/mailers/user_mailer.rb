class UserMailer < ActionMailer::Base
  default from: "energymonitoring@verdemonarca.com"

  def send_test_email()
    mail(to: "yalmasri@keepmoving.com.mx", subject: 'Test')
  end

  def send_welcome_email(user)
    @user = user
    @state = State.find_by_id(@user.state_id)
    @location = Location.find_by_id(@user.location_id)
    @propuesta= @user.crear_propuesta()
    mail(to: @user.email, subject: 'Bienvenido a Verde Monarca')
  end

  def send_donation_confirmation_email_to_admin(user, amount, creditos_vm, codigo_vm, donation_type)
    @user = user
    @amount = amount
    @creditos_vm = creditos_vm
    @codigo_vm = codigo_vm
	@donation_type = donation_type.to_s
    mail(to: "yalmasri@keepmoving.com.mx", subject: 'Contribución Verde Monarca')
  end

  def send_donation_confirmation_email_to_user(user, amount, creditos_vm, codigo_vm, donation_type)
    @user = user
    @amount = amount
    @creditos_vm = creditos_vm
    @codigo_vm = codigo_vm
	@donation_type = donation_type.to_s
    mail(to: @user.email, subject: 'Contribución Verde Monarca')
  end

  def send_purchase_confirmation_email_to_user(user, cart)
    @user = user
    @items_and_counts_arr = []
    cart.keys.each do |key|
      @items_and_counts_arr << {'item' => Item.find_by_id(key), 'quantity' => cart[key]}
    end
    mail(to: user.email, subject: 'Detalles de tu compra en la Tienda VM')
  end

  def send_purchase_confirmation_email_to_admin(user, cart)
    @user = user
    @items_and_counts_arr = []
    cart.keys.each do |key|
      @items_and_counts_arr << {'item' => Item.find_by_id(key), 'quantity' => cart[key]}
    end
    mail(to: "yalmasri@keepmoving.com.mx" , subject: 'Compra en la Tienda VM')
  end

  def send_contract(user)
    @user = user
    file_name = user.id + "-" + user.clave_referencia
    attachments[file_name + '-Contrato_Compraventa.pdf'] = File.read('app/assets/contracts/' + file_name + '-Contrato_Compraventa.pdf', :mode => 'rb')
    attachments[file_name + '-Carta_Poder.pdf'] = File.read('app/assets/contracts/' + file_name + '-Carta_Poder.pdf', :mode => 'rb')
    mail(to: @user.email, subject: 'Contrato Verde Monarca - ' + @user.nombre + ' ' + @user.apellido)
  end
  
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Recuperación de Contraseña"
  end

  def send_contact(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(to: "lgalaviz@keepmoving.com.mx", subject: 'Forma de Contacto')
  end

  def send_registration
    mail(to: "lgalaviz@keepmoving.com.mx", subject: 'Registro de Verde Monarca')
  end

end
