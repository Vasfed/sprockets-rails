class SprocketsController < ActionController::Base
  caches_page :index, :show
  
  def index
    show
  end

  def show
		respond_to do |format|
			format.js  { render :text => SprocketManager.new(:js,  params[:id]).source, :content_type => "text/javascript" }
			format.css { render :text => SprocketManager.new(:css, params[:id]).source, :content_type => "text/css" }
		end
  end
end
