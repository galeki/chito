#ActionMailer::Base.delivery_method = CHITO_CONFIG[:mail][:method]
ActionMailer::Base.smtp_settings = CHITO_CONFIG[:mail][:settings]
#ActicoMailer::Base.smtp_settings = {
#    :address        => "smtp.gmail.com",
#    :port           => 587,
#    :domain         => "mydomain",
#    :user_name      => "myname",
#    :password       => "mypass",
#    :authentication => "plain",
#    :enable_starttls_auto => true
#}
