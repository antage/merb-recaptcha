require File.dirname(__FILE__) + '/spec_helper'

describe "Recaptcha#ajax" do
  describe "HTTP" do
    before(:each) do
      @response = dispatch_to(Recaptcha, "ajax")
    end

    it "should load script from api url" do
      @response.should have_xpath("//script[@src='http://api.recaptcha.net/js/recaptcha_ajax.js']")
    end

    it "should invoke Recaptcha.create using onload event" do
      @response.should have_xpath("//script[contains(., 'window.onload = function() { Recaptcha.create')]")
    end

    it "should send element_id ('recaptcha_without_callback')" do
      @response.should have_xpath("//script[contains(., 'Recaptcha.create') and contains(., \"getElementById('recaptcha_without_callback')\")]")
    end
    
    it "should create empty options array" do
      @response.should have_xpath("//script[contains(., 'Recaptcha.create') and contains(., 'var options = {};')]")
    end
    
    it_should_behave_like "ajax recaptcha"
  end

  describe "HTTPS" do
    before(:each) do
      @response = dispatch_to(Recaptcha, "ajax", {}, { "HTTPS" => "on" })
    end

    it "should load script from secure api url" do
      @response.should have_xpath("//script[@src='https://api-secure.recaptcha.net/js/recaptcha_ajax.js']")
    end

    it_should_behave_like "ajax recaptcha"
  end
end
