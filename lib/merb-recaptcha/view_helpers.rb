require 'builder'

module Merb # :nodoc:
  module Helpers # :nodoc:
    module Recaptcha

      # Display recaptcha widget in various ways.
      # 
      # * Display in-place:
      #     <%= recaptcha_tags :ajax => false, :noscript => false %>
      #
      # * Display in-place with <noscript></noscript> block:
      #     <%= recaptcha_tags :ajax => false, :noscript => true, :iframe_height => 100, :iframe_width => 100 %>
      #
      # * Dynamically create Recaptcha widget:
      #     <%= recaptcha_tags :ajax => true, :element_id => "recaptcha_place" %>
      #     <div id="recaptcha_place"></div>
      #   The above code bind javascript code on onload event:
      #     <script type="text/javascript">
      #     ....
      #     window.onload = function() { Recaptcha.create(....); }
      #     ....
      #     </script>
      #   If you use jQuery, you could use special value for :ajax parameter:
      #     <%= recaptcha_tags :ajax => :jquery %>
      #     <div id="recpatcha"></div>
      #   This code generates following:
      #     <script type="text/javascript">
      #     ....
      #     $(document).ready(function() { Recaptcha.create(....); });
      #     ....
      #     </script>
      #   You can specified callback function that will be invoked after widget has been created:
      #     <%= recaptcha_tags :ajax => true, :callback => "Recaptcha.focus_response_field" %>
      #     <div id="recaptcha"></div>
      #   This code will set focus on response field of created widget.
      #
      # For both displaying ways, you can customize widget:
      #   <%= recaptcha_tags :theme => "clean", :tabindex => 2 %>
      # More detailed description of customizing options is at http://recaptcha.net/apidocs/captcha/client.html
      #
      # Default values of options:
      # * :ajax => false
      # * :element_id => "recaptcha"
      # * :callback => nil
      # * :noscript => false
      # * :iframe_height => 300
      # * :iframe_width => 500
      #
      def recaptcha_tags(options = {})
        public_key = Merb::Plugins.config[:merb_recaptcha][:public_key] 

        ajax = options.delete(:ajax) || false # boolean or :jquery
        element_id = options.delete(:element_id) || "recaptcha" # string, html element id, only if ajax == true
        callback = options.delete(:callback) # string, javascript function name, only if ajax == true
        noscript = options.delete(:noscript) || false # boolean
        iframe_height = options.delete(:iframe_height) || 300 # integer, only if noscript == true
        iframe_width = options.delete(:iframe_width) || 500 # integer, only if noscript == true

        api_url = if request.ssl?
          Merb::Recaptcha::API_SECURE_SERVER
        else
          Merb::Recaptcha::API_SERVER
        end

        result = ""
        xhtml = Builder::XmlMarkup.new(:target => result, :indent => 2) 
        if ajax
          xhtml.script(:type => "text/javascript", :src => "#{api_url}/js/recaptcha_ajax.js") {}
          xhtml.script(:type => "text/javascript") do
            options_and_callback = callback.nil? ? options : options.merge(:callback => callback)
            xhtml << "var options = #{hash_to_json(options_and_callback)};\n"
            if ajax == :jquery
              xhtml.text!("$(document).ready(function() { Recaptcha.create('#{public_key}', document.getElementById('#{element_id}'), options); });\n")
            else
              xhtml.text!("window.onload = function() { Recaptcha.create('#{public_key}', document.getElementById('#{element_id}'), options); }\n")
            end
          end
        else
          unless options.empty?
            xhtml.script(:type => "text/javascript") do
              xhtml << "var RecaptchaOptions = #{hash_to_json(options)};\n"
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
