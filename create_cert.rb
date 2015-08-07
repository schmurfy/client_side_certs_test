
# nice explanations of the various formats:
# http://serverfault.com/questions/9708/what-is-a-pem-file-and-how-does-it-differ-from-other-openssl-generated-key-file

class ClientCertGenerator
  def initialize()
    @output_path = "clients"
    @input_path  = "server"
  end
  
  def generate_key(user_name)
    basename = File.join(@output_path, user_name)
    
    # generate public/private keypair for client
    subj = "/CN=#{user_name}"
    system("openssl req -new -sha1 -newkey rsa:1024 -nodes -keyout #{basename}.key -out #{basename}.csr -subj '#{subj}'")
    
    # sign it with server private key
    system(%{openssl x509 -req -days 365 -CA #{ca_base()}.crt -CAkey #{ca_base}.key -CAcreateserial -in #{basename}.csr -out #{basename}.crt})
    
    # and generate client certificate
    system(%{openssl pkcs12 -export -clcerts -in #{basename}.crt -inkey #{basename}.key -out #{basename}.p12})
    
    # cleanup, only keep p12 file (the p12 files contain both keys)
    system("rm #{basename}.{csr,crt,key}")
  end

private
  def ca_base
    File.join(@input_path, "test.local")
  end
  
end

if ARGV.size != 1
  puts "Usage: #{$0} <user_name>"
  exit
end


generator = ClientCertGenerator.new
generator.generate_key( ARGV[0] )
