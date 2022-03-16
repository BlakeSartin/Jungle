class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_email(order, email)
    @order = order
    @email = email
    mail(to: @email, subject: "Thank you for your recent purchase! This is your order ID: #{order.id}")
end
end
