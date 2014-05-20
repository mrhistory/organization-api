module OrganizationAPI

  class Application
    attr_accessor :name, :url, :icon_image_url
    attr_reader :id

    def initialize(params)
      @name = params[:name] ||= nil
      @url = params[:url] ||= nil
      @icon_image_url = params[:icon_image_url] ||= nil
      @id = params[:_id] ||= nil
    end

    def to_json
      hash = {
        name: @name,
        url: @url,
        icon_image_url: @icon_image_url
      }
      hash[:_id] = @id unless @id.nil?
      hash.to_json
    end
  end

end