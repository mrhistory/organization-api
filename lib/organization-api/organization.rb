module OrganizationAPI

  class Organization
    attr_accessor :name, :address1, :address2, :city, :state, :zipcode, :phone_number, :admins, :applications

    def initialize(params)
      @name = params[:name] ||= nil
      @address1 = params[:address1] ||= nil
      @address2 = params[:address2] ||= nil
      @city = params[:city] ||= nil
      @state = params[:state] ||= nil
      @zipcode = params[:zipcode] ||= nil
      @phone_number = params[:phone_number] ||= nil
      @admins = params[:admins] ||= nil
      @applications = params[:applications] ||= nil
    end

    def to_json
      {
        name: @name,
        address1: @address1,
        address2: @address2,
        city: @city,
        state: @state,
        zipcode: @zipcode,
        phone_number: @phone_number,
        admins: @admins,
        applications: @applications
      }.to_json
    end
  end

end