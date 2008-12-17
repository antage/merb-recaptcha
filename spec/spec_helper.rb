require 'rubygems'
require 'spec'
require 'merb-core'

$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require File.join(File.dirname(__FILE__), '..', 'lib', 'merb-recaptcha')

default_options = {
  :testing     => true,
  :adapter     => 'runner',
  :merb_root   => File.dirname(__FILE__) / 'fixture',
  :log_stream  => STDOUT
}
options = default_options.merge($START_OPTIONS || {})

Merb.disable(:initfile)
Merb::BootLoader.after_app_loads do
  Merb::Plugins.config[:merb_recaptcha][:public_key] = "QAAAAAA--public-key--AAAAAAQ"
  Merb::Plugins.config[:merb_recaptcha][:private_key] = "QAAAAAA--private-key--AAAAAAAQ"

  Merb::Router.prepare { default_routes }
  Merb::RecaptchaMixin.const_set(:DO_NOT_IGNORE_RECAPTCHA_IN_TESTING_ENV, true)
end
Merb.start_environment(options)

Spec::Runner.configure do |config|
  config.include Merb::Test::ViewHelper
  config.include Merb::Test::RouteHelper
  config.include Merb::Test::ControllerHelper

  config.mock_with :mocha
end

describe "ajax recaptcha", :shared => true do
  it "should invoke Recaptcha.create" do
    @response.should have_xpath("//script[contains(., 'Recaptcha.create')]")
  end

  it "should send public key to Recaptcha.create" do
    @response.should have_xpath("//script[contains(., 'Recaptcha.create') and contains(., '#{Merb::Plugins.config[:merb_recaptcha][:public_key]}')]")
  end

  it "should not send private key to anything" do
    @response.should_not have_xpath("//*[contains(., '#{Merb::Plugins.config[:merb_recaptcha][:private_key]}')]")
  end
end
