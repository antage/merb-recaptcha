require 'builder'

module Merb
  module Helpers
    module Recaptcha
      API_SERVER = "http://api.recaptcha.net"
      API_SECURE_SERVER = "https://api-secure.recaptcha.net"

      def recaptcha_tags(options = {})
        public_key = Merb::Plugins.config[:merb_recaptcha][:public_key] 

        ajax = options.delete(:ajax) || false # boolean or :jquery
        element_id = options.delete(:element_id) || "recaptcha" # string, html element id, only if ajax == true
        callback = options.delete(:callback) # string, javascript function name, only if ajax == true
        noscript = options.delete(:noscript) || false # boolean
        iframe_height = options.delete(:iframe_height) || 300 # integer, only if noscript == true
        iframe_width = options.delete(:iframe_width) || 500 # integer, only if noscript == true

        api_url = if request.ssl?
          API_SECURE_SERVER
        else
          API_SERVER
        end

        result = ""
        xhtml = Builder::XmlMarkup.new(:target => result, :indent => 2) 
        if ajax
          xhtml.script(:type => "text/javascript", :src => "#{api_url}/js/recaptcha_ajax.js") {}
          xhtml.script(:type => "text/javascript") do
            options_and_callback = callback.nil? ? options : options.merge(:callback => callback)
            xhtml.text!("var options = #{hash_to_json(options_and_callback)};\n")
            if ajax == :jquery
              xhtml.text!("$(document).ready(function() { Recaptcha.create('#{public_key}', document.getElementById('#{element_id}'), options); });\n")
            else
              xhtml.text!("window.onload = function() { Recaptcha.create('#{public_key}', document.getElementById('#{element_id}'), options); }\n")
            end
          end
        else
          unless options.empty?
            xhtml.script(:type => "text/javascript") do
              xhtml.text!("var RecaptchaOptions = #{hash_to_json(options)};\n")
            end
          end
          xhtml.script(:type => "text/javascript", :src => "#{api_url}/challenge?k=#{public_key}") {}
          if noscript
            xhtml.noscript do
              xhtml.iframe(:src => "#{api_url}/noscript?k=#{public_key}", :height => iframe_height, :width => iframe_width, :frameborder => 0) {}
              xhtml.br
              xhtml.textarea(:name => "recaptcha_challenge_field", :rows => 3, :cols => 40) {}
              xhtml.input :name => "recaptcha_response_field", :type => "hidden", :value => "manual_challenge"
            end
          end
        end
        result
      end

      private

      def hash_to_json(hash)
        result = "{"
        result << hash.map do |k, v|
          if ! v.is_a?(String) || k.to_s == "callback" 
            "\"#{k}\": #{v}"
          else
            "\"#{k}\": \"#{v}\""
          end
        end.join(", ")
        result << "}"
      end
    end
  end
end
