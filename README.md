cnsd-locate-web: Consected Locate web site
==========================================

This Ruby on Rails project is an open source demonstration of how to perform certain geo-location functions in conjunction with the cnsd-locate service at: https://github.com/philayres/cnsd-locate

A demonstration of the site is at: http://services.consected.com 

What it does
------------

The home page of the website is a JQuery AJAX page to:

  1. make a request that attempts geolocation based on recognition of the user's IP address
  2. provide the user the opportunity to identify the location on a map and with a city, state, postal code
  3. confirm the location was correct or not
  4. if the location was not close, use the browser geolocation capability, based on the user's permission
  5. re-confirm the identified location
  6. for the closest location, show Twitter geolocated tweets pinned to the map, and in a list ordered by distance from the user's location

The user interactions are requested so that feedback from the user can feed into more accurate results in the future.

The aim is to extend this to also show Foursquare and Flickr geolocated posts on the map, to provide a more complete picture of activity in the local area.

Third-party APIs
----------------

The following external APIs are currently used:

Google Maps Javascript API
Twitter REST API (search API) without requiring a user's authentication (works in application mode only at this point, although there are plans to incorporate Oauth2 functionality to provide more user specific results in the future)


License
-------

The Consected name and any site-specific content is copyright (2015) Consected LLC, Massachusetts, USA. Credits to specific data providers and public APIs are displayed on the home page of the website. Please ensure that if you use any of this functionality or data that you credit the owners / providers appropriately.

Source Code is licensed under the Apache License, Version 2.0 (the "License"). See LICENSE for details.



