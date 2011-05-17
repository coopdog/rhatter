require 'omniauth/oauth'
require 'multi_json'

# Omniauth strategy for using oauth2 and force.com 
# Author: qwall@salesforce.com
#
module OmniAuth
  module Strategies
    class Forcedotcom < OAuth2
     
       def initialize(app, client_id = nil, client_secret = nil, options = {}, &block)
        client_options = {
          :site => "https://prerellogin.pre.salesforce.com",
          :authorize_path      => "/services/oauth2/authorize",
          :access_token_path   => "/services/oauth2/token"
        }
        super(app, :forcedotcom, client_id, client_secret, client_options, &block) 
      end

      def request_phase
        options[:response_type] ||= 'code'
        super
      end

      def callback_phase
        options[:grant_type] ||= 'authorization_code'
        super
      end

       def auth_hash
          OmniAuth::Utils.deep_merge(super, {
            'instance_url' => @access_token['instance_url']
          })
       end
      
    end
  end
end