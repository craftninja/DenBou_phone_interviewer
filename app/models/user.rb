class User < ActiveRecord::Base

  def self.create_or_update_with_omniauth(auth)
    user = where(provider: auth["provider"], uid: auth["uid"]).first_or_initialize
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.access_token = auth["credentials"]["token"]
    user.email = auth["info"]["email"]
    user.first_name = auth["info"]["first_name"]
    user.last_name = auth["info"]["last_name"]
    user.save!
    user
  end

end