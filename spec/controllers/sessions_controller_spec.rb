require 'rails_helper'

describe SessionsController, type: :request do

  let (:user) { create(:user) }
  let (:unsaved_user) { build(:user) }

  describe 'valid user' do
    before do
      log_in(user)
    end

    it 'returns success status' do
      expect(response.status).to eq(200)
    end

    it 'returns token on header' do
      expect(response.headers['Authorization']).to be_present
    end
  end

  describe 'invalid user' do
    before do
      log_in(unsaved_user)
    end

    it 'returns unauthorized status' do
      expect(response.status).to eq(401)
    end

    it 'does not returns token on header' do
      expect(response.headers['Authorization']).not_to be_present
    end
  end
  

  describe 'valid user but wrong password' do
    before do
      log_in(user, "wrong_password")
    end

    it 'returns unauthorized status' do
      expect(response.status).to eq(401)
    end

    it 'returns wrong password message' do
      expect(response.body).to include("Invalid Email or password")
    end

    it 'does not return token on header' do
      expect(response.headers['Authorization']).not_to be_present
    end
  end

  describe 'logging out' do
    it 'returns 204' do
      delete '/sign_out'

      expect(response).to have_http_status(204)
    end
  end
end
