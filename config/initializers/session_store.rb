# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_perfomance_app_client_session',
  :secret      => '12a17d837872114422b84d3bdc5ad201249e89b5805f4608861fe55a6f082ff75f118129c9cc0dcd2b03b621027173ece45af08eee05103503ebbce48d77cf96'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
