# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_recaptcha] = {
    :public_key => "",
    :private_key => ""
  }
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
    require 'merb-recaptcha/constants.rb'
    require 'merb-recaptcha/view_helpers.rb'
    require 'merb-recaptcha/exceptions.rb'
    require 'merb-recaptcha/controller_mixin.rb'
    module Merb::GlobalHelpers # :nodoc:
      include Merb::Helpers::Recaptcha
    end
    class Merb::Controller # :nodoc:
      include Merb::RecaptchaMixin
    end
  end
  
  Merb::BootLoader.after_app_loads do
    # code that can be required after the application loads
  end
  
  Merb::Plugins.add_rakefiles "merb-recaptcha/merbtasks"
end
