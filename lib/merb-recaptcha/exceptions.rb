module Merb # :nodoc:
  module Recaptcha
    class GenericError < RuntimeError; end

    # We weren't able to verify the public key.
    # Possible solutions:
    #
    # * Did you swap the public and private key? It is important to use the correct one
    # * Did you make sure to copy the entire key, with all hyphens and underscores, but without any spaces? The key should be exactly 40 letters long.
    #
    class InvalidSitePublicKey < GenericError; end

    # We weren't able to verify the private key.
    # Possible solutions:
    #
    # * Did you swap the public and private key? It is important to use the correct one
    # * Did you make sure to copy the entire key, with all hyphens and underscores, but without any spaces? The key should be exactly 40 letters long.
    #         
    class InvalidSitePrivateKey < GenericError; end

    # The challenge parameter of the verify script was incorrect.
    class InvalidRequestCookie < GenericError; end

    # The parameters to /verify were incorrect, make sure you are passing all the required parameters.
    class VerifyParamsIncorrect < GenericError; end

    # reCAPTCHA API keys are tied to a specific domain name for security reasons.
    class InvalidReferrer < GenericError; end
  end
end
