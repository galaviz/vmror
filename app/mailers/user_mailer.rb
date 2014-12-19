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
    mail(to: @user.email, subject: 'Usuario se ha registrado a verdemonarca')
  end

  def send_donation_confirmation_email(user, amount, creditos_vm, codigo_vm)
    @user = user
    @amount = amount
    @creditos_vm = creditos_vm
    @codigo_vm = codigo_vm
    mail(to: "yalmasri@keepmoving.com.mx", subject: 'Contribución Pay-It-Forward')
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
    file_name = user.nombre[0,2] + user.apellido[0,2]
    attachments[file_name + '-Contrato.pdf'] = File.read('app/assets/contracts/' + file_name + '-Contrato.pdf', :mode => 'rb')
    attachments[file_name + '-Otorgacion.pdf'] = File.read('app/assets/contracts/' + file_name + '-Otorgacion.pdf', :mode => 'rb')
    mail(to: @user.email, subject: 'Contrato Verde Monarca - ' + @user.nombre + ' ' + @user.apellido)
  end
  
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Recuperación de Contraseña"
  end

end
