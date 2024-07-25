class UserMailer < ApplicationMailer
  default from: 'pantry-chef-notifier@onrender.com'

  def expiration_notice(user, food, expiration_notice, recipes)
    @user = user
    @food = food
    @expiration_notice = expiration_notice
    @recipes = recipes

    mail(to: @user.email, subject: "#{@food.name}の消費期限通知")
  end
end
