ActionMailer::Base.delivery_method = CHITO_CONFIG[:mail][:method]
ActionMailer::Base.smtp_settings = CHITO_CONFIG[:mail][:settings]
