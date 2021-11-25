# frozen_string_literal: true

# Module for use methods for api connection (new spec version)
module ApiUtils
	# Parse response body
	def json
		JSON.parse(response.body)
	end

	# Log user into app
	def log_in(user)
		post '/api/login', params: {
      user: {
        email: user.email,
        password: user.password
      }
    }
	end
end
  