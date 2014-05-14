require 'spec_helper'

describe OrganizationAPI do
  before(:all) do
    OrganizationAPI.set_endpoint(
      'https://organization-service-dev.herokuapp.com',
      'web_service_user',
      'messingaroundinboats')
  end
end