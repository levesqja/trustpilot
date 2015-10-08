class TrustPilot
  
  require 'base64'
  require 'faraday'
 
  attr_accessor :acces_token
  attr_accessor :response 
 
  
  #TrustPilot.new({''})
  def initialize(attributes)
    
    conn = Faraday.new(:url => 'https://api.trustpilot.com/v1') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.post do |req|
      req.url '/oauth/oauth-business-users-for-applications/accesstoken' 
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.headers['Authorization'] = 'Basic ' + Base64.urlsafe_encode64( attributes['api_key'] + ':' + attributes['api_secret'] )
      req.body = to_body(attributes) 
    end
    
    @access_token = response.body['access_token']
    @response = response
     
  end
 
  def to_body(attributes)
    response = Hash.new
    response['username'] = attributes['username']
    response['password'] = attributes['password']
    response['grant_type'] = 'password'
    
 
    response
  end
  
  
  def self.reviews
    
    response = conn.get do |req|                           # GET http://sushi.com/search?page=2&limit=100
      req.url '/reviews/latest'
      req.params['language'] = 'fr'
      req.param['token'] = @acces_token
    end
    
    response.body
    
  end
  
end
