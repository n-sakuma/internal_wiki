if Rails.env.production?
  ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
    access_key_id: Settings.aws.access_key,
    secret_access_key: Settings.aws.secret_key
end
