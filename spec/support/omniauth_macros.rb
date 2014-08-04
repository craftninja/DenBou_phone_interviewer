module OmniauthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:linkedin] = {
      'provider' => 'linkedin',
      'uid' => '123545',
      'info' => {
        'first_name' => 'Nathanael',
        'last_name' => 'mock',
        'email' => 'mock@email.com',
        'image' => 'http://cdn.cutestpaw.com/wp-content/uploads/2014/02/l-Angora-Bunny-with-a-haircut.jpg'
      },
      'credentials' => {
        'token' => 'mock_token',
      },
    }
  end

end
