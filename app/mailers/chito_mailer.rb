class ChitoMailer < ActionMailer::Base
  default :from => CHITO_CONFIG[:mail][:from]

  def comment_notifier(email, comment, post, request)
    @email = email
    @comment = comment
    @post = post
    @request = request
    mail :to =>  email,
         :subject => I18n.t("txt.mail.comment_notifier.email_title", :post => post.title)
  end

  def forgot_password(user, request)
    @user = user
    @request = request
    mail :to => user.email,
         :subject => I18n.t("txt.mail.reset_password.email_title")
  end

end
