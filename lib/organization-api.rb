require 'organization-api/version'
require 'organization-api/organization'
require 'organization-api/application'
require 'rest-client'
require 'json'

module OrganizationAPI

  def self.set_endpoint(host, username, password)
    @endpoint = RestClient::Resource.new(host, username, password)
  end

  def self.get_users
    response = @endpoint['users/.json'].get
    user_list = []
    parse_json(response.to_str).each do |user|
      user_list << User.new(user)
    end
    return user_list
  rescue Exception => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  
  protected

  def self.parse_json(json)
    JSON.parse(json, symbolize_names: true)
  end

end
