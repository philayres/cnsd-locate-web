module ApplicationHelper
  
  def go_back    
    if @go_back       
      link_to("Cancel", @go_back, class: "btn btn-warning").html_safe
    end
  end
end
