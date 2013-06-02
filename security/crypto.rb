require 'openssl'
require 'base64' 
class STD
  class Crypt
    # Initializer Sets location to key pairs for PGP encryption
    def initialize data_path
      @data_path = data_path
      @private   = get_key '/home/ec2-user/security/private.secure.pem'
      @public    = get_key '/home/ec2-user/security/public_key.pem'
    end
 
    # Encrypt the string and output it as a BASE64 encoded blob
    def encrypt_string message
      Base64::encode64(@public.public_encrypt(message)).rstrip
    end
 
    # Decrypt the string as plain text ascii
    def decrypt_string message
      @private.private_decrypt Base64::decode64(message)
    end
 
    private
    # Load the keys into memory
    def get_key filename
      OpenSSL::PKey::RSA.new File.read(filename)
    end
  end
end
