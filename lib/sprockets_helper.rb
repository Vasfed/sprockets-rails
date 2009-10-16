module SprocketsHelper
	def sprockets_include_tag(name = nil)
		if name.nil?
			javascript_include_tag("/sprockets.js")
		else
			javascript_include_tag("/sprockets/#{name}")
		end
	end
end
