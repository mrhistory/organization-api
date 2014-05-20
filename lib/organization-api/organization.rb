require 'organization-api/application'

module OrganizationAPI

  class Organization
    attr_accessor :name, :address1, :address2, :city, :state, :zipcode, :phone_number, :admins, :applications
    attr_reader :id

    def initialize(params)
      @id = params[:_id] ||= nil
      @name = params[:name] ||= nil
      @address1 = params[:address1] ||= nil
      @address2 = params[:address2] ||= nil
      @city = params[:city] ||= nil
      @state = params[:state] ||= nil
      @zipcode = params[:zipcode] ||= nil
      @phone_number = params[:phone_number] ||= nil
      @admins = params[:admins] ||= nil
      
      @applications = []
      set_applications_from_json(params[:applications]) unless params[:applications].nil?
    end

    def to_json
      hash = {
        name: @name,
        address1: @address1,
        address2: @address2,
        city: @city,
        state: @state,
        zipcode: @zipcode,
        phone_number: @phone_number,
        admins: @admins
      }
      hash[:applications] = get_applications_json
      hash.to_json
    end

    
    protected

    def get_applications_json
      apps = []
      @applications.each do |app|
        apps << app.to_json
      end
      return apps
    end

    def set_applications_from_json(json)
      json.each do |app|
        @applications << Application.new(app)
      end
    end
  end

end