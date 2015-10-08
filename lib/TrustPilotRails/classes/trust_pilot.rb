class TrustPilot
  
  require 'base64'
  require 'rest-client'

  attr_accessor :access_token
  attr_accessor :response 
 
  def get_client(url)
    return RestClient::Resource.new(
    url
    ) 
  end
  
  #TrustPilot.new({''})
  def initialize(attributes)
    
    
    
    url = 'https://api.trustpilot.com/v1'
    
    # conn = Faraday.new(:url => 'https://api.trustpilot.com/v1') do |faraday|
    #   faraday.request  :url_encoded             # form-encode POST params
    #   faraday.response :logger                  # log requests to STDOUT
    #   faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    # end

    full_url =  url+'/oauth/oauth-business-users-for-applications/accesstoken'

    client = get_client(full_url)
    
    auth = 'Basic ' + Base64.urlsafe_encode64( attributes['api_key'] + ':' + attributes['api_secret'] )
    response_rest = client.post( to_body(attributes) , { :content_type => 'application/x-www-form-urlencoded', :authorization => auth } )
     
    @access_token = response_rest.body.to_h.symbolize_keys![:access_token]
    @response = response_rest.body
     
  end
 
  def to_body(attributes)
    response = Hash.new
    response['username'] = attributes['username']
    response['password'] = attributes['password']
    response['grant_type'] = 'password'
    
    response
  end
  
  
  def self.reviews
    
    # response = conn.get do |req|                           # GET http://sushi.com/search?page=2&limit=100
    #   req.url '/reviews/latest'
    #   req.params['language'] = 'fr'
    #   req.param['token'] = @acces_token
    # end
    #
    # response.body
    
  end
  
end
