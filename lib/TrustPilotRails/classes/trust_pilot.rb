class TrustPilot
  
  require 'base64'
  require 'rest-client'

  attr_accessor :access_token
  attr_accessor :response 
 
  URL = 'https://api.trustpilot.com/v1'
     
  def get_client(url)
    return RestClient::Resource.new(
    url
    ) 
  end
  
  #TrustPilot.new({''})
  def initialize(attributes)
    
    
    

    
    # conn = Faraday.new(:url => 'https://api.trustpilot.com/v1') do |faraday|
    #   faraday.request  :url_encoded             # form-encode POST params
    #   faraday.response :logger                  # log requests to STDOUT
    #   faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    # end

    full_url =  URL+'/oauth/oauth-business-users-for-applications/accesstoken'

    client = get_client(full_url)
    
    auth = 'Basic ' + Base64.urlsafe_encode64( attributes['api_key'] + ':' + attributes['api_secret'] )
    response_rest = client.post( to_body(attributes) , { :content_type => 'application/x-www-form-urlencoded', :authorization => auth } )
     
    @access_token = JSON.parse(response_rest.body)['access_token']
    @response = response_rest.body
     
  end
 
  def to_body(attributes)
    response = Hash.new
    response['username'] = attributes['username']
    response['password'] = attributes['password']
    response['grant_type'] = 'password'
    
    response
  end
  
  
  def reviews
    
    full_url =  URL+'/reviews/latest'

    client = get_client(full_url)
     
    response_rest = client.get(:params => {:language => 'fr', :token => self.access_token)
    JSON.parse(response_rest.body)
  
  end
  
end
