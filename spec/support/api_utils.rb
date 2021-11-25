# frozen_string_literal: true

# Module for use methods for api connection (new spec version)
module ApiUtils
	# Parse response body
	def json
		JSON.parse(response.body)
	end

	# Log user into app
	def log_in(user, wrong_password = nil)
		post '/api/sign_in', params: {
      user: {
        email: user.email,
        password: wrong_password || user.password
      }
    }
	end
end
