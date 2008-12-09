module Merb
  module Recaptcha
    class GenericError < RuntimeError; end
    class InvalidSitePublicKey < GenericError; end
    class InvalidSitePrivateKey < GenericError; end
    class InvalidRequestCookie < GenericError; end
    class VerifyParamsIncorrect < GenericError; end
    class InvalidReferrer < GenericError; end
  end
end
