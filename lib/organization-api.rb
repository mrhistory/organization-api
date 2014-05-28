require 'organization-api/version'
require 'organization-api/organization'
require 'organization-api/application'
require 'rest-client'
require 'json'

module OrganizationAPI

  def self.set_endpoint(host, username, password)
    @endpoint = RestClient::Resource.new(host, username, password)
  end

  def self.create_organization(organization)
    response = @endpoint['organizations/.json'].post(organization.to_json)
    Organization.new(parse_json(response.to_str))
  rescue Exception => e
    raise Exception, e.response if e.respond_to? response
    raise Exception, e.message
  end

  def self.delete_organization(id)
    response = @endpoint["organizations/#{id}.json"].delete
    parse_json(response.to_str)[:deleted]
  rescue Exception => e
    raise Exception, e.response if e.respond_to? response
    raise Exception, e.message
  end

  def self.get_organization(id)
    response = @endpoint["organizations/#{id}.json"].get
    Organization.new(parse_json(response.to_str))
  rescue Exception => e
    raise Exception, e.response if e.respond_to? response
    raise Exception, e.message
  end

  def self.get_organizations
    response = @endpoint['organizations/.json'].get
    orgs = []
    parse_json(response.to_str).each do |org|
      orgs << Organization.new(org)
    end
    return orgs
  rescue Exception => e
    raise Exception, e.response if e.respond_to? response
    raise Exception, e.message
  end

  def self.update_organization(organization)
    puts "\n\nORGANIZATION: #{organization.to_json}\n\n"
    response = @endpoint["organizations/#{organization.id}.json"].put(organization.to_json)
    Organization.new(parse_json(response.to_str))
  rescue Exception => e
    raise Exception, e.response if e.respond_to? response
    raise Exception, e.message
  end

  def self.create_application(application)
    response = @endpoint['applications/.json'].post(application.to_json)
    Application.new(parse_json(response.to_str))
  rescue Exception => e
    raise Exception, e.response if e.respond_to? response
    raise Exception, e.message
  end

  def self.delete_application(id)
    response = @endpoint["applications/#{id}.json"].delete
    parse_json(response.to_str)[:deleted]
  rescue Exception => e
    raise Exception, e.response if e.respond_to? response
    raise Exception, e.message
  end

  def self.get_application(id)
    response = @endpoint["applications/#{id}.json"].get
    Application.new(parse_json(response.to_str))
  rescue Exception => e
    raise Exception, e.response if e.respond_to? response
    raise Exception, e.message
  end

  def self.get_applications
    response = @endpoint['applications/.json'].get
    apps = []
    parse_json(response.to_str).each do |app|
      apps << Application.new(app)
    end
    return apps
  rescue Exception => e
    raise Exception, e.response if e.respond_to? response
    raise Exception, e.message
  end

  def self.update_application(app)
    response = @endpoint["applications/#{app.id}.json"].put(app.to_json)
    Application.new(parse_json(response.to_str))
  rescue Exception => e
    raise Exception, e.response if e.respond_to? response
    raise Exception, e.message
  end

  def self.get_applications_for_organization(org)
    applications = []
    org.applications.each do |app|
      applications << get_application(app.id)
    end
    return applications
  rescue Exception => e
    raise Exception, e.response if e.respond_to? response
    raise Exception, e.message
  end

  
  protected

  def self.parse_json(json)
    JSON.parse(json, symbolize_names: true)
  end

end
