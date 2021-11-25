require 'rails_helper'

describe RegistrationsController, type: :request do

  let (:user) { build(:user) }
  let (:existing_user) { create(:user) }
  let (:invalid_user) { build(:user, :invalid) }

  describe 'creating user' do
    context "valid data" do 
      before do
        post '/api/registration', params: {
          user: {
            email: user.email,
            password: user.password
          }
        }
      end
  
      it 'returns success status' do
        expect(response.status).to eq(200)
      end
  
      it 'returns token pn header' do
        expect(response.headers['Authorization']).to be_present
      end
    end
    
    context 'duplicated email' do
      before do
        post '/api/registration', params: {
          user: {
            email: existing_user.email,
            password: existing_user.password
          }
        }
      end
  
      it 'returns 400' do
        expect(response.status).to eq(400)
      end
    end

    context 'invalid data' do
      before do
        post '/api/registration', params: {
          user: {
            email: invalid_user.email,
            password: invalid_user.password
          }
        }
      end
  
      it 'returns 400' do
        expect(response.status).to eq(400)
      end

      it 'returns error messages when data is empty' do
        expect(response.body).to include("Password can't be blank")
      end
    end
  end
end