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
    @app1 = OrganizationAPI::Application.new( {
      name: 'App1',
      url: 'https://not-a-real-url.com',
      icon_image_url: 'http://not-a-real-url.com/app1-icon.png'
      })
    @app2 = OrganizationAPI::Application.new( {
      name: 'App2',
      url: 'https://not-a-real-url2.com',
      icon_image_url: 'https://not-a-real-url.com/app2-icon.png'
      })
  end

  it 'should create and delete and organization' do
    response = OrganizationAPI.create_organization(@org1)
    response.name.should eq(@org1.name)
    response = OrganizationAPI.delete_organization(response.id)
    response.should eq(true)
  end

  it 'should return a particular organization' do
    response = OrganizationAPI.create_organization(@org1)
    org = OrganizationAPI.get_organization(response.id)
    org.name.should eq(response.name)
    OrganizationAPI.delete_organization(org.id)
  end

  it 'should return a list of organizations' do
    OrganizationAPI.create_organization(@org1)
    OrganizationAPI.create_organization(@org2)
    response = OrganizationAPI.get_organizations
    response[0].name.should eq(@org1.name)
    OrganizationAPI.delete_organization(response[0].id)
    OrganizationAPI.delete_organization(response[1].id)
  end

  it 'should update an organization' do
    org = OrganizationAPI.create_organization(@org1)
    org.name = 'New Name'
    org = OrganizationAPI.update_organization(org)
    org.name.should eq('New Name')
    OrganizationAPI.delete_organization(org.id)
  end

  it 'should create and delete an application' do
    app = OrganizationAPI.create_application(@app1)
    app.name.should eq(@app1.name)
    response = OrganizationAPI.delete_application(app.id)
    response.should eq(true)
  end

  it 'should return a particular application' do
    app = OrganizationAPI.create_application(@app1)
    response = OrganizationAPI.get_application(app.id)
    response.name.should eq(app.name)
    OrganizationAPI.delete_application(app.id)
  end

  it 'should return a list of applications' do
    OrganizationAPI.create_application(@app1)
    OrganizationAPI.create_application(@app2)
    response = OrganizationAPI.get_applications
    response[0].name.should eq(@app1.name)
    OrganizationAPI.delete_application(response[0].id)
    OrganizationAPI.delete_application(response[1].id)
  end

  it 'should update an application' do
    app = OrganizationAPI.create_application(@app1)
    app.name = 'New Name'
    response = OrganizationAPI.update_application(app)
    response.name.should eq('New Name')
    OrganizationAPI.delete_application(response.id)
  end

  it 'should create, get, and delete an organization with an application' do
    app = OrganizationAPI.create_application(@app1)
    org = OrganizationAPI.create_organization(@org1)
    org.applications << app
    puts "\n\nAPPLICATIONS: #{org.applications.inspect}\n\n"
    org = OrganizationAPI.update_organization(org)
    org.applications = OrganizationAPI.get_applications_for_organization(org)
    org.applications[0].name.should eq(app.name)
    OrganizationAPI.delete_organization(org.id)
    OrganizationAPI.delete_application(app.id)
  end
end