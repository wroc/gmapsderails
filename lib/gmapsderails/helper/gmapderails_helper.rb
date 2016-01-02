module GmapsderailsHelper
  # shortcut helper for marker display with convenient default settings
  # @params [String] builder is a json string
  def gmapsderails(builder,css_name=nil)
    options = {
      :map_options => { :auto_adjust => true},
      :markers     => { :data => builder, :options => {:do_clustering => true} },
      :css_name   => css_name
    }
    gmaps(options)
  end

  # full helper to pass all variables and their options
  # @params [Hash] options is a Hash containing data and options. Example: { markers:{ data: @json, options: { do_clustering: true } } }
  def gmaps(options)
    options_with_indifferent_access = options.with_indifferent_access
    view_helper                     = Gmapsderails::ViewHelper.new(options_with_indifferent_access)
    
    js_dependencies = if Gmapsderails.escape_js_url
                        view_helper.js_dependencies_array
                      else
                        view_helper.js_dependencies_array.map(&:html_safe)
                      end

    render :partial => '/gmapsderails/gmapsderails', 
           :locals  => { 
             :options         => options_with_indifferent_access, 
             :js_dependencies => js_dependencies,
             :dom             => view_helper.dom_attributes
            }
  end

end
