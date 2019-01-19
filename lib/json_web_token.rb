# class JsonWebToken
#  class << self
#    def encode(payload, exp = 24.hours.from_now)
#      payload[:exp] = exp.to_i
#      JWT.encode(payload, Rails.application.secrets.secret_key_base)
#    end

#    def decode(token)
#      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
#      HashWithIndifferentAccess.new body
#    rescue
#      nil
#    end
#  end
# end
class JsonWebToken
 class << self
   def encode(payload)
     JWT.encode(payload, Rails.application.secrets.secret_key_base.to_s)
   end

   def decode(token)
    decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base).first
    HashWithIndifferentAccess.new(decoded_token)
    rescue
    nil
   end
 end
end