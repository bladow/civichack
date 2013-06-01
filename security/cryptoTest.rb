require 'crypto.rb'
keys_dir = File.expand_path "~/security/.pgp/"
#Dir.mkdir keys_dir unless Dir.exists? keys_dir
s = STD::Crypt.new keys_dir
secret_msg = s.encrypt_string "This is private"
exposed_msg = s.decrypt_string secret_msg
puts "The secret message was encrypted and then decrypted to:  \"#{exposed_msg}\""
