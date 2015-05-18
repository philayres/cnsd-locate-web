cnsd.tweets = function(){
  return this;
};

cnsd.tweets.prototype = cnsd.inherit_from(cnsd.callbacks, {
  near_here: function(lat, lng, cb_success, cb_fail){    
    var url = '/services/tweets/?' + $.param({lat:lat, lng:lng});    
    this.get_data(url, cb_success, cb_fail);
    
  },  
  near_here_for_block: function(block, lat, lng){
    var self = this;
    cnsd.ajax_working(block);
    
    this.near_here(
      lat, lng,
      function(data){
        cnsd.ajax_done(block);
        
        self._distances = data.results.distances;
        
        for(var dti in data.tweets){
          if(data.tweets.hasOwnProperty(dti)){
            var t = data.tweets[dti];
            t._distance = 100;
            
            if(t.geo && t.geo.coordinates){
              var l1 = t.geo.coordinates;
              console.log (l1);
              t._distance =  self._distances[t.id_str] * 0.621371;
                      //Math.pow((parseFloat(l1[0]) - parseFloat(lat)),2)  + Math.pow((parseFloat(l1[1]) - parseFloat(lng)), 2);
              console.log(t._distance);
            }
            
            var h = '<div class="tweet-html">' + twemoji.parse(t.text) + '</div>';
            if(t.entities && t.entities.urls){              
              t.entities._instagram = [];
              
              for(var ui in t.entities.urls){
                if(t.entities.urls.hasOwnProperty(ui)){
                  var u = t.entities.urls[ui];                  
                  var a = '<a class="in-tweet-url" href="#" data-short-href="'+u.url+'" data-orig-url="'+u.expanded_url+'" title="open link in new window" data-toggle="popover" data-content="The full URL is: '+u.expanded_url+' " data-trigger="hover" data-placement="bottom">'+u.display_url+'</a>';
                  h = h.replace(u.url, a);
                  var eurl = ''+u.expanded_url;
                  if(eurl.indexOf('://instagram.com') > 0){
                    if(eurl.indexOf('http://') == 0)
                      eurl.replace('http://', 'https://');
                    t.entities._instagram.push({media_url_https: eurl + 'media?size=l'});
                  }
                }
              }              
            }
            
            t._html = h;
            
          }
        }
        
        data.tweets.sort(function(a,b){
          var res = 1;
          
          res = (a._distance < b._distance) ? -1 : 1;
          
          return res;  
          
        });
        
        cnsd.view_template(block, 'tweets-near-here-template', data);  
        self.loaded(block, data);
      }, 
      function(data){
        cnsd.ajax_done(block);
        if(data.code == 'NOT_FOUND'){
          block.html('<p class="error">We didn\'t find any tweets near your current location.</p>');
        }else{
        block.html('<p class="error">Something went wrong. Sorry we can\'t get any tweets at this time.</p>');
        }
      }      
    );
  },
  
  process_tweets: function(tweets, locate){
    var l = locate;
    var infowindow = new google.maps.InfoWindow({
          content: ""
      });
      
    var tweet_clicked = function(tblock){
      $('.tweet-item').removeClass('active-tweet');
      tblock.addClass('active-tweet');
    };  
    
    for(var ti in tweets){
        if(tweets.hasOwnProperty(ti)){
          var t = tweets[ti];
          var geo;
          
          if(t.geo)            
            geo = t.geo.coordinates;
            
          if(geo){
            var lat = geo[0];
            var lng = geo[1];
            
            var myLatlng = new google.maps.LatLng(lat, lng);            
            
            (function(){
              var marker = new google.maps.Marker({
                  position: myLatlng,
                  map: l.map,
                  title: '@'+t.user.screen_name                
              });

              var cs_html = '<div class="tweet-item in-map"><img class="img img-thumbnail" src="'+t.user.profile_image_url_https+'"/> @'+t.user.screen_name;
              cs_html += '<div>'+twemoji.parse(t.text)+'</div>';
              var content_string = '<div class="tweet-item in-map">' + cs_html + '</div></div>';
              
              var tblock = $('#tweet-item-' + t.id);
              
              google.maps.event.addListener(marker, 'click', function() {
                

                infowindow.setContent(content_string);              
                //infowindow.setPosition(myLatlng);
                infowindow.open(l.map, marker);
                
                 $('.tweet-list').scrollTo(tblock, {duration: 300});
                 tweet_clicked(tblock);
              });
              
              tblock.click(function(ev){
                ev.preventDefault();
                infowindow.setContent(content_string);              
                //infowindow.setPosition(myLatlng);
                infowindow.open(l.map, marker);
                tweet_clicked($(this));
              });
              
            })();
            
            $('a.in-tweet-url').click(function(ev){
              ev.preventDefault();
              var u = $(this).attr('data-short-href');
              window.open(u, '_blank');                
            }).popover();
           
           
          }
        }
      }    
  }
  
});