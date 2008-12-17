require 'net/http'

module Merb # :nodoc:
  module RecaptchaMixin

    # This method checks challenge and response data via Recaptcha API server.
    # * It will return true, if filled captcha response is correct.
    # * It will return false, if captcha is incorrect.
    # * It will raise exception, if Recaptcha API server returns error.
    #
    def recaptcha_valid?
      return true if (Merb.testing? && !Merb::RecaptchaMixin.const_defined?(:DO_NOT_IGNORE_RECAPTCHA_IN_TESTING_ENV))
      response = Net::HTTP.post_form(URI.parse("#{Merb::Recaptcha::API_VERIFY_SERVER}/verify"), {
        :privatekey => Merb::Plugins.config[:merb_recaptcha][:private_key],
        :remoteip => request.remote_ip,
        :challenge => params[:recaptcha_challenge_field],
        :response => params[:recaptcha_response_field]
      })
      answer, error = response.body.split.map { |s| s.chomp }
      if answer == "true"
        true
      else
        case error
        when "incorrect-captcha-sol" then false
        when "invalid-site-public-key" then raise Merb::Recaptcha::InvalidSitePublicKey
        when "invalid-site-private-key" then raise Merb::Recaptcha::InvalidSitePrivateKey
        when "invalid-request-cookie" then raise Merb::Recaptcha::InvalidRequestCookie
        when "verify-params-incorrect" then raise Merb::Recaptcha::VerifyParamsIncorrect
        when "invalid-referrer" then raise Merb::Recaptcha::InvalidReferrer
        else
          raise Merb::Recaptcha::GenericError
        end
      end
    end
  end
end
