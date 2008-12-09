require File.dirname(__FILE__) + '/spec_helper'

describe "Recaptcha#noajax_without_noscript" do
  describe "HTTP" do
    before(:each) do
      @response = dispatch_to(Recaptcha, "noajax_without_noscript")
    end

    it "should load script from api url" do
      @response.should have_xpath("//script[@src='http://api.recaptcha.net/challenge?k=#{Merb::Plugins.config[:merb_recaptcha][:public_key]}']")
    end

    it "should not send private key to anything" do
      @response.should_not have_xpath("//*[contains(., '#{Merb::Plugins.config[:merb_recaptcha][:private_key]}')]")
    end

    it "should not have noscript element" do
      @response.should_not have_xpath("//noscript")
    end
    
    it "should not have RecaptchaOptions array initialization" do
      @response.should_not have_xpath("//script[contains(., 'var RecaptchaOptions')]")
    end
  end

  describe "HTTPS" do
    before(:each) do
      @response = dispatch_to(Recaptcha, "noajax_without_noscript", {}, { "HTTPS" => "on" })
    end

    it "should load script from secure api url" do
      @response.should have_xpath("//script[@src='https://api-secure.recaptcha.net/challenge?k=#{Merb::Plugins.config[:merb_recaptcha][:public_key]}']")
    end

    it "should not send private key to anything" do
      @response.should_not have_xpath("//*[contains(., '#{Merb::Plugins.config[:merb_recaptcha][:private_key]}')]")
    end
  end
end
