module Gmapsderails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a Gmapsderails initializer and copies the assets to the public folder.'

      def copy_locale
        if Rails::VERSION::MINOR >= 1
          copy_file "#{source_assets_base_path}gmapsderails.base.js.coffee",       "#{destination_assets_base_path}gmapsderails.base.js.coffee"
          copy_file "#{source_assets_base_path}gmapsderails.googlemaps.js.coffee", "#{destination_assets_base_path}gmapsderails.googlemaps.js.coffee"
          copy_file "../../../app/assets/stylesheets/gmapsderails.css", "app/assets/stylesheets/gmapsderails.css"
        else
        #I don't copy manifests, kind of useless
          copy_file "#{source_js_base_path}gmapsderails.base.js",       "#{destination_js_base_path}gmapsderails.base.js"
          copy_file "#{source_js_base_path}gmapsderails.googlemaps.js", "#{destination_js_base_path}gmapsderails.googlemaps.js"
          copy_file "../../../app/assets/stylesheets/gmapsderails.css",     "public/stylesheets/gmapsderails.css"
        end
      end
      
      def source_assets_base_path
        '../../../app/assets/javascripts/gmapsderails/'
      end
      
      def destination_assets_base_path
        'app/assets/javascripts/gmapsderails/'
      end
      
      def source_js_base_path
        "../../../public/javascripts/gmapsderails/"
      end
      
      def destination_js_base_path
        "public/javascripts/gmapsderails/"
      end

      def show_readme
        readme 'README' if behavior == :invoke
      end
    end
  end
end
