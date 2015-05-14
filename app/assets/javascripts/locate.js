
cnsd.locate = function (){
  return this;
};

cnsd.locate.prototype = cnsd.inherit_from(cnsd.callbacks, {
  
  get_location: function(cb_success, cb_fail, force_ip){
    var self = this;
    if(!force_ip) force_ip = '';
    var url = '/services/locate/'+force_ip;
    
    var done = function(data){
      self.latitude = parseFloat(data.latitude);
      self.longitude = parseFloat(data.longitude);      
      cb_success(data);
    };
    
    this.get_data(url, done, cb_fail);
    
  },
  get_location_for_block: function(yli_block, force_ip){
    var self = this;
    cnsd.ajax_working(yli_block);
    
    this.get_location(
      function(data){
        cnsd.ajax_done(yli_block);
        if(data){
          
          cnsd.view_template(yli_block, 'your-location-is-template', data);  
          self.loaded(yli_block, data);
        }
      }, 
      function(data){
        cnsd.ajax_done(yli_block);
        if(data.code == 'NOT_FOUND'){
          yli_block.html('<p class="error">We didn\'t find a location for the IP address your device (or network) reported to us. To see how this would look if we had an address for you, <a class="do-demo-iplocate" href="#">click here</a>.</p>');
        }else{
        yli_block.html('<p class="error">Something went wrong. Sorry we can\'t get your location at this time.</p>');
        }
      },
      force_ip
    );
  },
  
  get_location_from_browser: function(cb_success){    
    var self = this;
    var handle_errors = function(error){
            switch(error.code)
            {
                case error.PERMISSION_DENIED: alert("user did not share geolocation data");
                break;
 
                case error.POSITION_UNAVAILABLE: alert("could not detect current position");
                break;
 
                case error.TIMEOUT: alert("retrieving position timed out");
                break;
 
                default: alert("unknown error");
                break;
            }
        };
    
    var handle_result = function(position){      
      var ll = {latitude: position.coords.latitude, longitude: position.coords.longitude};
      self.latitude = parseFloat(ll.latitude);
      self.longitude = parseFloat(ll.longitude);     
      cb_success(ll);
    };
    
    navigator.geolocation.getCurrentPosition(handle_result, handle_errors);
           
  },
          
  show_map: function(map_block_id){
    var mapOptions = {
          center: { lat: this.latitude, lng: this.longitude},
          zoom: 10
        };
    this.map = new google.maps.Map(document.getElementById(map_block_id), mapOptions);
  }
  
});

