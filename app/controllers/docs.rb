class Docs < Application

  def show(page)
    render :template => "docs/#{page}", :layout => false
  end
  
end
