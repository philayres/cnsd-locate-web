
cnsd.locate = function (){
  return this;
};

cnsd.locate.prototype = cnsd.inherit_from(cnsd.callbacks, {
  
  send_updated_location: function(data, cb_success, cb_fail){    
    var url = '/services/locate/updated_location';    
    this.do_ajax_request({url: url, method: 'post', data: this.location_data}, cb_success, cb_fail);
  },
  send_ip_location_feedback: function(data, cb_success, cb_fail){    
    var url = '/services/locate/ip_location_ok';    
    this.do_ajax_request({url: url, method: 'post', data: this.location_data}, cb_success, cb_fail);
  },
  
  get_location: function(cb_success, cb_fail, force_ip){
    var self = this;
    if(!force_ip) force_ip = '';
    var url = '/services/locate/'+force_ip;
    
    var done = function(data){
      self.latitude = parseFloat(data.latitude);
      self.longitude = parseFloat(data.longitude);      
      self.location_data = data;
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
        cnsd.view_template(yli_block, 'your-location-failed-template', data);  
        
      },
      force_ip
    );
  },
  
  get_location_from_browser: function(cb_success, cb_fail){    
    var self = this;
    var handle_errors = function(error){
      var data = {};
      switch(error.code)
      {
          case error.PERMISSION_DENIED: 
            data = {code: 'PERMISSION_DENIED', code: "user did not share geolocation data"};
          break;

          case error.POSITION_UNAVAILABLE: 
            data = {code: 'POSITION_UNAVAILABLE', code: "could not detect current position"};
          break;

          case error.TIMEOUT: 
            data = {code: 'TIMEOUT', code: "retrieving position timed out"};
          break;

          default: 
            data = {code: 'UNKNOWN_ERROR', code: "unknown error"};
          break;          
      }
      
      if(cb_fail) cb_fail(data);
            
    };
    
    var handle_result = function(position){      
      var ll = {latitude: position.coords.latitude, longitude: position.coords.longitude};
      self.latitude = parseFloat(ll.latitude);
      self.longitude = parseFloat(ll.longitude);  
      self.reverse_geocode(cb_success, cb_success);
      
    };
    
    navigator.geolocation.getCurrentPosition(handle_result, handle_errors);
           
  },
          
  show_map: function(map_block_id, options){
    
    if(!options) options = {};
    
    $(".wait-for-map-loaded").hide();
    $(".show-while-map-loading").show();
    
    
    var zoom = 10;
    if(options.zoom) zoom = options.zoom;
    
    var mapOptions = {
      center: { lat: this.latitude, lng: this.longitude},
      zoom: zoom
    };
    this.map = new google.maps.Map(document.getElementById(map_block_id), mapOptions);

    google.maps.event.addListenerOnce(this.map, 'idle', function(){    
      $(".wait-for-map-loaded").show();
      $(".show-while-map-loading").hide();
    });
    
    var goldstar = {
      path: 'M 125,5 155,90 245,90 175,145 200,230 125,180 50,230 75,145 5,90 95,90 z',
      fillColor: 'purple',
      fillOpacity: 0.8,
      scale: 0.1,
      strokeColor: 'gold',
      strokeWeight: 1.4
    }
    
    if(options.mark_loc){
      var myLatlng = new google.maps.LatLng(this.latitude, this.longitude);
      var marker = new google.maps.Marker({
          position: myLatlng,
          map: this.map,
          title: 'You are here',
          icon: goldstar
      });
    }
    
  },
  set_map_options: function(options){
    this.map.setOptions(options);
  },
          
  reverse_geocode: function(cb_success, cb_fail){
    var self = this;
    if(!this.geocoder) this.geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(this.latitude, this.longitude);
    
    this.geocoder.geocode({'latLng': latlng}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        if (results[1]) {
          var data = {latitude: self.latitude, longitude: self.longitude, location_details: {}};
          var dl = data.location_details;
          for(var ri in results){
            if(results.hasOwnProperty(ri)){
              var r = results[ri];
              if(r.types.indexOf('street_address')>=0){                
                dl.street_address = '';
                if(r.address_components[0].types.indexOf('street_number')>=0)
                  dl.street_address = r.address_components[0].long_name + ' ';
                if(r.address_components[1].types.indexOf('route')>=0)
                  dl.street_address += r.address_components[1].long_name;
              }
              if(r.types.indexOf('country')>=0) dl.country_name = r.address_components[0].long_name;
              if(r.types.indexOf('administrative_area_level_1')>=0) dl.subdivision_1_name = r.address_components[0].long_name;
              if(r.types.indexOf('administrative_area_level_2')>=0) dl.subdivision_2_name = r.address_components[0].long_name;
              if(r.types.indexOf('locality')>=0) dl.city_name = r.address_components[0].long_name;
              if(r.types.indexOf('postal_code')>=0) data.postal_code = r.address_components[0].long_name;
            }
          }
          self.location_data = data;
          cb_success(data);
          
        } else {
          cb_fail({code: 'NOT_FOUND', code: 'No results found'});
        }
      } else {
        cb_fail({code: 'FAILED', code: 'Geocoder failed due to: ' + status});
      }
    });
  }
  
});

