class UserMailer < ActionMailer::Base
  default from: "energymonitoring@verdemonarca.com"

  def send_test_email()
    mail(to: "mauriziocalo07@gmail.com", subject: 'Test')
  end

  def send_welcome_email(user)
    @user = user
    @propuesta= @user.crear_propuesta()
    mail(to: "admin@verdemonarca.com", subject: 'Usuario se ha registrado a verdemonarca')
  end

  def send_donation_confirmation_email(user, amount, creditos_vm, codigo_vm)
    @user = user
    @amount = amount
    @creditos_vm = creditos_vm
    @codigo_vm = codigo_vm
    mail(to: "admin@verdemonarca.com", subject: 'Contribución Pay-It-Forward')
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
    mail(to: "admin@verdemonarca.com" , subject: 'Compra en la Tienda VM')
  end

end
