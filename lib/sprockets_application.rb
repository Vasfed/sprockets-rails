class SprocketsApplication
	cattr_accessor :use_page_caching, :user_google_closure_compiler
	self.use_page_caching = true  
	self.use_google_closure_compiler = true

	def initialize(name = nil)
		@name = name.blank? ? nil : name
		@name = "#{@name}.js" unless @name && File.extname(@name) == '.js'
	end

	def source
		concatenation.to_s
	end

	protected
	def secretary
		@@secretary = {}
		@@secretary[@name] ||= Sprockets::Secretary.new(configuration.merge(:root => RAILS_ROOT))
	end
	
	def configuration
		returning conf = YAML.load(IO.read(File.join(RAILS_ROOT, "config", "sprockets.yml"))) || {} do
			if @name then
				dir = conf[:load_path].find{|d| !Dir[File.join(d,@name)].empty? }
				conf[:source_files] = [File.join(dir, @name)] if dir
			end
		end
	end

	def concatenation
		secretary.reset! unless source_is_unchanged?
		secretary.concatenation
	end
	
	def concatenation_with_google_closure_compiler
    GoogleClosureCompiler::Javascript.new(concatenation_without_google_closure_compiler)
  end
  alias_method_chain :concatenation, :google_closure_compiler if use_google_closure_compiler and defined? GoogleClosureCompiler


	def source_is_unchanged?
		previous_source_last_modified, @source_last_modified = 
			@source_last_modified, secretary.source_last_modified

		previous_source_last_modified == @source_last_modified
	end

	class << self
		def routes(map)
			map.resources(:sprockets)
		end
	end
end
