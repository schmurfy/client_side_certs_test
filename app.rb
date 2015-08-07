require 'sinatra'


class MyApp < Sinatra::Application
  get '/' do
    if request.env['HTTP_X_CLIENT_VERIFY'] == "SUCCESS"
      cert = request.env["HTTP_X_SSL_CLIENT_S_DN"]
      "Hello #{request.env['HTTP_X_SSL_USER']}"
    else
      "Failed"
    end
  end
end
