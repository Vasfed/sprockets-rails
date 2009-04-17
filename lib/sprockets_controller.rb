class SprocketsController < ActionController::Base
  caches_page :show
  
  def index
    show
  end

  def show
    sprocket = if params[:id]
      SprocketsApplication.sprocket(params[:id])
    else
      SprocketsApplication
    end
    render :text => sprocket.source, :content_type => "text/javascript"
  end
end
