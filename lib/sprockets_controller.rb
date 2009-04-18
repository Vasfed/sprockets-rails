class SprocketsController < ActionController::Base
  caches_page :index, :show
  
  def index
    show
  end

  def show
		respond_to do |format|
			format.js  { render :text => Sprocket.new(:js,  params[:id]).source, :content_type => "text/javascript" }
			format.css { render :text => Sprocket.new(:css, params[:id]).source, :content_type => "text/css" }
		end
  end
end
