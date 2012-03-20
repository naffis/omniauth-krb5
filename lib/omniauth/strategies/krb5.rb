require 'omniauth'
require 'rkerberos'

module OmniAuth
  module Strategies
    class Krb5
      include OmniAuth::Strategy

      args [:realm]
      option :title, "Kerberos Authentication"

      def initialize( app, *args, &block )
        super
        @krb5 = Kerberos::Krb5.new
        @krb5.set_default_realm(options.realm)             
      end
                 
      def request_phase
        OmniAuth::Form.build(:title => options.title, :url => callback_path) do
          text_field 'Username', 'username'
          password_field 'Password', 'password'
        end.to_response
      end

      def callback_phase
        return fail!(:invalid_credentials) if !authentication_response
        super
      end
      
      uid do
        username_with_realm
      end
      
      info do 
        { :name  => username } 
      end

      def realm           
        @krb5.get_default_realm
      end
      
      protected
        
        def username_with_realm
          user_with_realm = username.dup
          user_with_realm += "@#{realm}" unless username.include?('@')          
        end
        
        def username
          request['username']
        end

        def password
          request['password']
        end

        def authentication_response
          unless @authentication_response
            return unless username && password
                        
            begin
              @authentication_response = @krb5.get_init_creds_password(username_with_realm, password)
            rescue Krb5Auth::Krb5::Exception
              @authentication_response = false                          
            rescue => err
              @authentication_response = false               
            ensure
              @krb5.close
            end
          end

          @authentication_response
        end

    end
  end
end
