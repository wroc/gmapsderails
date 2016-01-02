require 'net/http'
require 'uri'
require 'json'
require 'ostruct'

module Gmapsderails
  require 'gmapsderails/extensions/enumerable'
  require 'gmapsderails/extensions/hash'

  autoload :ModelHandler,     'gmapsderails/model_handler'
  autoload :ActsAsGmappable,  'gmapsderails/acts_as_gmappable'

  autoload :JsBuilder,        'gmapsderails/js_builder'
  autoload :JsonBuilder,      'gmapsderails/json_builder'
  autoload :ViewHelper,       'gmapsderails/view_helper'
  autoload :GmapsderailsHelper,'gmapsderails/helper/gmapsderails_helper'
  
  autoload :BaseNetMethods,   'gmapsderails/api_wrappers/base_net_methods'
  autoload :Geocoder,         'gmapsderails/api_wrappers/geocoder'
  autoload :Direction,        'gmapsderails/api_wrappers/direction'
  autoload :Places,           'gmapsderails/api_wrappers/places'
  autoload :ObjectAccessor,   'gmapsderails/object_accessor'

  mattr_accessor :http_proxy, :escape_js_url

  self.escape_js_url = true
  
  # This method geocodes an address using the GoogleMaps webservice
  # options are:
  # * address: string, mandatory
  # * lang: to set the language one wants the result to be translated (default is english)
  # * raw: to get the raw response from google, default is false
  def Gmapsderails.geocode(address, lang="en", raw = false, protocol = "http")
    ::Gmapsderails::Geocoder.new(address, {
      :language => lang, 
      :raw      => raw,
      :protocol => protocol
    }).get_coordinates
  end
  
  def Gmapsderails.create_json(object, &block)
    ::Gmapsderails::JsonBuilder.new(object).process(&block)
  end
  
  def Gmapsderails.create_js_from_hash(hash)
    ::Gmapsderails::JsBuilder.new(hash).create_js
  end
  
  # This method retrieves destination results provided by GoogleMaps webservice
  # options are:
  # * start_end: Hash { "from" => string, "to" => string}, mandatory
  # * options: details given in the github's wiki
  # * output: could be "pretty", "raw" or "clean"; filters the output from google
  #output could be raw, pretty or clean
  def Gmapsderails.destination(start_end, options={}, output="pretty")
     Gmapsderails::Direction.new(start_end, options, output).get
  end
  
  # does two things... 1) gecode the given address string and 2) triggers a a places query around that geo location
  # optionally a keyword can be given for a filter over all places fields (e.g. "Bungy" to give all Bungy related places)
  # IMPORTANT: Places API calls require an API key (param "key")
 
  def Gmapsderails.places_for_address(address, key, keyword = nil, radius = 7500, lang="en", raw = false)
    raise Gmapsderails::GeocodeInvalidQuery, "you must provide an address for a places_for_address query" if address.nil?
    raise "Google Places API requires an API key" if key.nil?
    res = Gmapsderails.geocode(address)  # will throw exception if nothing could be geocoded
    Gmapsderails.places(res.first[:lat], res.first[:lng], key, keyword, radius, lang, raw)
  end
  
  # does a places query around give geo location (lat/lng)
  # optionally a keyword can be given for a filter over all places fields (e.g. "Bungy" to give all Bungy related places)
  # IMPORTANT: Places API calls require an API key (param "key")
  def Gmapsderails.places(lat, lng, key, keyword = nil, radius = 7500, lang="en", raw = false, protocol = "https")
    Gmapsderails::Places.new(lat, lng, {
      :key      => key,
      :keyword  => keyword,
      :radius   => radius, 
      :lang     => lang,
      :raw      => raw,
      :protocol => protocol
    }).get
  end
  
  private
  
  class GeocodeStatus         < StandardError; end
  class GeocodeNetStatus      < StandardError; end
  class GeocodeInvalidQuery   < StandardError; end
  
  class DirectionStatus       < StandardError; end
  class DirectionNetStatus    < StandardError; end
  class DirectionInvalidQuery < StandardError; end
  
  class PlacesStatus          < StandardError; end
  class PlacesNetStatus       < StandardError; end
  class PlacesInvalidQuery    < StandardError; end
  
  def Gmapsderails.condition_eval(object, condition)
    case condition
    when Symbol, String        then object.send condition
    when Proc                  then condition.call(object)
    when TrueClass, FalseClass then condition
    end
  end
  
  # looks for proxy settings and returns a Net::HTTP or Net::HTTP::Proxy class
  def Gmapsderails.http_agent
    proxy = ENV['HTTP_PROXY'] || ENV['http_proxy'] || self.http_proxy
    if proxy
      proxy = URI.parse(proxy)
      http_agent = Net::HTTP::Proxy(proxy.host,proxy.port)
    else
      http_agent = Net::HTTP
    end
    http_agent
  end

end
