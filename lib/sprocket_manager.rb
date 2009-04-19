class SprocketManager

	def initialize(lang = :js, config = nil)
		@lang = lang
		if config.is_a? Symbol or config.is_a? String
			@configuration = load_configuration(config.to_sym)
		else
			@configuration = config
		end
	end



	def source
		concatenation.to_s
	end


	# comented out because I'm not sure if it will still work

	# def install_script
	# 	concatenation.save_to(asset_path)
	# end
	# 
	# def install_assets
	# 	secretary.install_assets
	# end

	protected
	def secretary
		@secretary ||= Sprockets::Secretary.new(configuration.merge(:root => Rails.root))
	end

	def configuration
		@configuration ||= load_configuration
	end

	def load_configuration(key = :default)
		returning conf = YAML.load_file(File.join(Rails.root, "config", "sprockets.yml")) || {} do
			# conf.collapse! @lang
			# conf.collapse! key
			conf.merge! conf.delete(@lang) if conf[@lang]
			conf.merge! conf.delete(key) if conf[key]
		end
	end

	def concatenation
		secretary.reset! unless source_is_unchanged?
		secretary.concatenation
	end

	# def asset_path
	# 	File.join(Rails.public_path, "sprockets.js")
	# end

	def source_is_unchanged?
		previous_source_last_modified, @source_last_modified = 
		@source_last_modified, secretary.source_last_modified

		previous_source_last_modified == @source_last_modified
	end
end
