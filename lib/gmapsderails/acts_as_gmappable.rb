module Gmapsderails
  module ActsAsGmappable
    extend ActiveSupport::Concern
          
    # This is a validation method which triggers the geocoding and save its results
    def process_geocoding
      Gmapsderails::ModelHandler.new(self, gmapsderails_options).retrieve_coordinates
    end
    
    # create json for one instance 
    def to_gmapsderails(&block)
      json = "["
      object_json = Gmapsderails.create_json(self, &block)
      json << object_json.to_s unless object_json.nil?
      json << "]"
    end

    module ClassMethods
      def acts_as_gmappable args = {}    
        
        validate :process_geocoding
        
        #instance method containing all the options to configure the behaviour of the gem regarding the current Model
        define_method "gmapsderails_options" do
          {
            :process_geocoding  => args[:process_geocoding].nil? ?  true : args[:process_geocoding],
            :check_process      => args[:check_process].nil?     ?  true : args[:check_process],
            :checker            => args[:checker]                || "gmaps",

            :lat_column         => args[:lat]                    || "latitude",
            :lng_column         => args[:lng]                    || "longitude",

            # purposefully no default. 
            # Leaving out the :position arg means we are using the default lat/lng to store coordinates
            :position           => args[:position], 
                                                                 
            :msg                => args[:msg]                    || "Address invalid",
            :validation         => args[:validation].nil?        ?   true  : args[:validation],

            :language           => args[:language]               || "en",
            :protocol           => args[:protocol]               || "http",

            :address            => args[:address]                || "gmapsderails_address",
            :callback           => args[:callback],
            :normalized_address => args[:normalized_address]
          }
        end
      end
    end # ClassMethods
  end # ActsAsGmappable
end
