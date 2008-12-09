require File.dirname(__FILE__) + '/spec_helper'

describe "Recaptcha#ajax_with_callback" do
  describe "HTTP" do
    before(:each) do
      @response = dispatch_to(Recaptcha, "ajax_with_callback")
    end

    it "should load script from api url" do
      @response.should have_xpath("//script[@src='http://api.recaptcha.net/js/recaptcha_ajax.js']")
    end

    it "should send element_id ('recaptcha_with_callback')" do
      @response.should have_xpath("//script[contains(., 'Recaptcha.create') and contains(., \"getElementById('recaptcha_with_callback')\")]")
    end
    
    it "should create options array containing callback value ('test_callback')" do
      @response.should have_xpath("//script[contains(., 'Recaptcha.create') and contains(., 'var options = {\"callback\": test_callback};')]")
    end
    
    it_should_behave_like "ajax recaptcha"
  end

  describe "HTTPS" do
    before(:each) do
      @response = dispatch_to(Recaptcha, "ajax_with_callback", {}, { "HTTPS" => "on" })
    end

    it "should load script from secure api url" do
      @response.should have_xpath("//script[@src='https://api-secure.recaptcha.net/js/recaptcha_ajax.js']")
    end

    it_should_behave_like "ajax recaptcha"
  end
end
