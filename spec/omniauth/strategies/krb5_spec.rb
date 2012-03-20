require File.expand_path('../../../spec_helper', __FILE__)

describe OmniAuth::Strategies::Krb5 do

  def app
    Rack::Builder.new {
      use OmniAuth::Test::PhonySession
      run lambda { |env| [404, {'Content-Type' => 'text/plain'}, [env.key?('omniauth.auth').to_s]] }
    }.to_app
  end  
      
  let(:fresh_strategy) { Class.new OmniAuth::Strategies::Krb5 }  
  subject { fresh_strategy }
   
  it 'should be initialized with default realm' do
    instance = subject.new(app)
    instance.realm.should == Kerberos::Krb5.new.get_default_realm
  end
 
  it 'should be initialized with custom realm' do
    instance = subject.new(app, "EXAMPLE.COM")
    instance.options.realm.should == "EXAMPLE.COM"
    instance.realm.should == "EXAMPLE.COM"
  end
  
  it 'should set name in info hash' do
    instance = subject.new(app)    
    instance.stub!(:request).and_return({'username' => 'test1234', 'password' => '1234'})
    instance.info[:name].should == 'test1234'    
  end

  it 'should add realm to uid' do
    instance = subject.new(app)    
    instance.stub!(:request).and_return({'username' => 'test1234', 'password' => '1234'})
    realm = Kerberos::Krb5.new.get_default_realm
    instance.uid.should == "test1234@#{realm}"
  end
       
  describe 'GET /auth/krb5' do
     before do
       get '/auth/krb5'
     end

  end       

  describe 'POST /auth/krb5/callback' do
    
  
  end
       
end
