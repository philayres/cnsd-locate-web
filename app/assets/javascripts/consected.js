cnsd = {
  ajax_working: function(block){
    block.addClass('ajax-running');
  },
  ajax_done: function(block){
    block.removeClass('ajax-running');
  },
          
  view_template: function(block, template_name, data){
    var source = $('#'+template_name).html();
    var template = Handlebars.compile(source);
    var html = template(data);
    block.html(html);
    cnsd.reset_page_size();
  },
          
  reset_page_size:function(){
    var bh = $('body').height();
    var hh = $('html').height();
    if(bh < hh) $('body').height(hh);
  },
          
  inherit_from: function(original_prototype, new_t){
    function F() {}
    F.prototype = original_prototype;    
    $.extend(F.prototype, new_t);
    return F.prototype;
  },
          
 html_entity_map: {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': '&quot;',
    "'": '&#39;'
  },

  escape_html: function (string) {
    return String(string).replace(/[&<>"']/g, function (s) {
      return cnsd.html_entity_map[s];
    });
  }          

};

cnsd.callbacks = {
  
  loaded: function(block, data){
    if(!this.loaded_callbacks) this.loaded_callbacks = [];
    
    for(var lc in this.loaded_callbacks){
      if(this.loaded_callbacks.hasOwnProperty(lc)){
        var lcs = this.loaded_callbacks[lc];
        window.setTimeout(function(){
          lcs(block, data);
        },1);
      }      
    }
  },
  
  add_loaded_callback: function(f){
    if(!this.loaded_callbacks) this.loaded_callbacks = [];
    this.loaded_callbacks.push(f);
  },
  
  get_data: function(url, cb_success, cb_fail, cb_always){        
    $.ajax({url: url}).done(
      function(data){
        if(!data || data.code == 'NOT_FOUND'){
          if(cb_fail) cb_fail(data);
          return null;
        }      
        if(cb_success) cb_success(data);      
      }).fail(function(data){
        if(cb_fail) cb_fail(data);
      }).always(function(){
        if(cb_always) cb_always(data);
      });
  }
};


$('html').ready(function(){
  cnsd.reset_page_size();  
  
  $(document).on('click', 'a.view-image-modal', function(ev){
    ev.preventDefault;    
    var v = $('#view-image-modal');
    v.find('.modal-title').html('View Image');
    var src = $(this).attr('data-img-src');
    v.find('.modal-body').html('<img src="'+src+'" class="img"/>');
    
  });
  
});