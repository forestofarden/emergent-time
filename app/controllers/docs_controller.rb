class DocsController < ActionController::Base

  def show
    render "docs/#{params[:id]}"
  end
  
end
