require 'spec_helper'

describe OrganizationAPI do
  before(:all) do
    OrganizationAPI.set_endpoint(
      'https://organization-service-dev.herokuapp.com',
      'web_service_user',
      'messingaroundinboats')
  end

  before(:each) do
    @org1 = OrganizationAPI::Organization.new( {
        name: 'Org1',
        address1: '123 Fake St.',
        city: 'Lawrenceville',
        state: 'Ga',
        zipcode: '30044',
        phone_number: '1234567890'
      })
    @org2 = OrganizationAPI::Organization.new( {
        name: 'Org2',
        address1: '456 Fake St.',
        city: 'Lawrenceville',
        state: 'Ga',
        zipcode: '30044',
        phone_number: '3216540987'
      })
  end
end