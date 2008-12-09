require File.dirname(__FILE__) + '/spec_helper'

describe "Recaptcha#noajax_with_noscript" do
  describe "HTTP" do
    before(:each) do
      @response = dispatch_to(Recaptcha, "noajax_with_noscript")
    end

    it "should load script from api url" do
      @response.should have_xpath("//script[@src='http://api.recaptcha.net/challenge?k=#{Merb::Plugins.config[:merb_recaptcha][:public_key]}']")
    end

    it "should not send private key to anything" do
      @response.should_not have_xpath("//*[contains(., '#{Merb::Plugins.config[:merb_recaptcha][:private_key]}')]")
    end

    it "should not have RecaptchaOptions array initialization" do
      @response.should_not have_xpath("//script[contains(., 'var RecaptchaOptions')]")
    end
    
    it "should have noscript element" do
      @response.should have_xpath("//noscript")
    end

    it "should have iframe in noscript element" do
      @response.should have_xpath("//noscript/iframe")
    end

    it "should have iframe with specified height and width (250x250)" do
      @response.should have_xpath("//noscript/iframe[@height=250 and @width=250]")
    end

    it "should have br element in noscript element" do
      @response.should have_xpath("//noscript/br")
    end

    it "should have textarea in noscript element" do
      @response.should have_xpath("//noscript/textarea[@name='recaptcha_challenge_field']")
    end

    it "should have hidden input element in noscript element" do
      @response.should have_xpath("//noscript/input[@name='recaptcha_response_field' and @type='hidden' and @value='manual_challenge']")
    end
  end

  describe "HTTPS" do
    before(:each) do
      @response = dispatch_to(Recaptcha, "noajax_with_noscript", {}, { "HTTPS" => "on" })
    end

    it "should load script from secure api url" do
      @response.should have_xpath("//script[@src='https://api-secure.recaptcha.net/challenge?k=#{Merb::Plugins.config[:merb_recaptcha][:public_key]}']")
    end

    it "should not send private key to anything" do
      @response.should_not have_xpath("//*[contains(., '#{Merb::Plugins.config[:merb_recaptcha][:private_key]}')]")
    end
  end
end
