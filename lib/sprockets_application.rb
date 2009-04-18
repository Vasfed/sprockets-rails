module SprocketsApplication
  def self.routes(map, method = :resource)
    if method == :resource
      map.resource(:sprockets, :only => :show)
    elsif method == :resources
      map.resources(:sprockets, :only => [:index, :show])
    end
  end
end
