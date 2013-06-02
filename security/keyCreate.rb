require 'openssl'

# Create the public/private key pair with 2048 bit RSA encryption
key = OpenSSL::PKey::RSA.new 2048

# write out the private key
open 'private_key.pem', 'w' do |io| 
	io.write key.to_pem 
end
#TODO make sure this private key is securily stored
# Wtire out the public key to disk
open 'public_key.pem', 'w' do |io| 
	io.write key.public_key.to_pem 
end

# Protect the private key
cipher = OpenSSL::Cipher::Cipher.new 'AES-128-CBC'
pass_phrase = 'civichack' # Password to protect the private key

key_secure = key.export cipher, pass_phrase

open 'private.secure.pem', 'w' do |io|
	io.write key_secure
end
