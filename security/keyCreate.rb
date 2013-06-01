require 'rubygems'
require 'openpgp'

gpg = OpenPGP::Engine::GnuPG.new(:homedir => '.')
key_id = gpg.gen_key({
	:key_type	=> 'DSA',
	:key_length	=> 1024,
	:subkey_type	=> 'ELG-E',
	:subkey_length	=> 1024,
	:name		=> 'Civic Hack STD',
	:comment	=> nil,
	:email		=> 'admin@civichackstd.org',
	:passphrase	=> 'STD Secrets',
	:no_verbose	=> false,
})
