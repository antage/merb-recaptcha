require 'net/http'

module Merb
  module RecaptchaMixin
    def recaptcha_valid?
      response = Net::HTTP.post_form(URI.parse("http://api-verify.recaptcha.net/verify"), {
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
