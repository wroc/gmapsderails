require "gmapsderails/version"

module Gmapsderails
  require 'rails'
  require 'gmapsderails/base'

  class Engine < Rails::Engine
     initializer "gmapsderails view helpers" do |app|
       ActionView::Base.send :include, GmapsderailsHelper
     end
  end

  class Railtie < Rails::Railtie
     initializer "include acts_as_gmappable within ORM" do
       ActiveSupport.on_load(:active_record) do
         ActiveRecord::Base.send(:include, Gmapsderails::ActsAsGmappable)
       end

       ActiveSupport.on_load(:mongoid) do
         Mongoid::Document.send(:include, Gmapsderails::ActsAsGmappable)
       end
     end
  end

end
