class DevelopmentMailInterceptor
  def self.delivering_email( message )
    message.subject = "#{message.to} #{message.subject}"
    message.to = 'john@poeticsystems.com, yourloyalcustomer1@gmail.com'
  end
end