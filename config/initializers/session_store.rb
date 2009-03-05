# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_blog_2.2.0_session',
  :secret      => '353643becdd00933ca8b4c2e5ee721609462ccc788cb33886c4ef4055e464e7df2029f648f180f06fb29899460816a0ab3383369bcf5b5cc0e90f4756362934b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
