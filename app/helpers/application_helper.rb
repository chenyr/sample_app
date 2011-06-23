module ApplicationHelper
  def title 
    base_title = "InfoHub"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo 
    image_tag("app_logo.png", :alt => "Info Hub", :class => "round")
  end
  	
end
