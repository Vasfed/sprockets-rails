module SprocketsHelper
	def sprockets_asset_path(name = nil, format = :js)
		path = name ? "/sprockets/#{name}.#{format}" : "/sprockets.#{format}"
	end
	
	def sprockets_javascript_tag(name = nil)
		javascript_include_tag sprockets_asset_path(name, :js)
	end
	alias_method :sprockets_javascript_tag, :sprockets_include_tag
	
	def sprockets_stylesheet_tag(name = nil)
		stylesheet_link_tag sprockets_asset_path(name, :css)
	end
end
