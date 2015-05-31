module ApplicationHelper
  
  def go_back    
    if @go_back       
      link_to("Cancel", @go_back, class: "btn btn-warning").html_safe
    end
  end
  
  def cover_class    
    controller_name == 'pages' ? '' : 'inner cover contained text-left'    
  end
  
  def disabled_link caption, url, reason    
    c = {class: 'btn btn-default', disabled: true}
    title = t(@reason, raise: true) rescue @reason.to_s.humanize
    l = link_to caption, url, c  
    r = "<div style=\"display: inline-block\" data-toggle=\"tooltip\" title=\"#{title}\">#{l}</div>"
    
    r.html_safe
  end
  
end
