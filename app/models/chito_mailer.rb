class ChitoMailer < ActionMailer::Base
  
  def comment_notifier(email, comment, post, request)
    subject    I18n.t("txt.mail.comment_notifier.email_title", :post => post.title)
    recipients email
    from       CHITO_CONFIG[:mail][:from]
    sent_on    Time.now
    body       :comment => comment, :post => post, :request => request, :email => email
  end

  def forgot_password(user, request)
    subject    I18n.t("txt.mail.reset_password.email_title")
    recipients user.email
    from       CHITO_CONFIG[:mail][:from]
    sent_on    Time.now
    body       :user => user, :request => request
  end

end
