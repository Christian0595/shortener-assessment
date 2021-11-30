require 'rails_helper'

describe  LinksController, type: :request do
  # Create users with 10 links each
  let (:user) { create(:user_with_links) }
  let! (:second_user) { create(:user_with_links, links_count: 5) }
  let (:link) { build(:link)}
  let! (:created_link) { create(:link) }
  let! (:user_link) { create(:link, user: user) }

  context 'when user is logged in' do
    describe 'index' do
      before do
        log_in(user)
        get '/links', headers: {'Authorization' => response.headers['Authorization']}
      end
  
      it 'shows success status' do
        expect(response.status).to eq(200)
      end
  
      it 'returns only user links' do
        expect(json['data'].count).to eq(10)
      end
    end
    
    describe 'show' do
      before do
        log_in(user)
        @link = user.links.first
        @link_visits_count = @link.visits.count
        get "/#{@link.code}", headers: {'Authorization' => response.headers['Authorization']}
      end
  
      it 'returns redirect status' do
        expect(response.status).to eq(302)
      end
  
      it 'redirects to original link' do
        expect(response).to redirect_to(user.links.first.url)
      end

      it 'saves visits count' do
        @link.reload
        expect(@link.visits.count).to eq(@link_visits_count + 1)
      end

      it 'saves visit data' do
        expect(@link.visits.last.web_browser).to eq('Other')
      end
    end

    describe 'create' do
      context 'valid data' do
        before do
          log_in(user)
          @count = user.links.count
          post '/links', params: {
            link: {
              url: link.url
            }
          }, headers: {'Authorization' => response.headers['Authorization']}
        end

        it 'responds success code' do
          expect(response.status).to eq(200)
        end

        it 'responds link and code' do
          expect(json.dig('data', 'attributes', 'code')).not_to be_empty
          expect(json.dig('data', 'attributes', 'url')).not_to be_empty
        end
        
        it 'link is asociated to current user' do
          user.reload
          expect(user.links.count).to eq(@count + 1)
        end
      end

      context 'invalid data' do
        before do
          log_in(user)
          post '/links', params: {
            link: {
              url: ''
            }
          }, headers: {'Authorization' => response.headers['Authorization']}
        end

        it 'responds error code' do
          expect(response.status).to eq(400)
        end

        it 'returns link can not be empty' do
          expect(response.body).to include('Url can\'t be blank') 
        end
      end
    end

    describe 'update' do
      context 'tries to edit a link that is not his' do
        before do
          log_in(user)
          put "/links/#{created_link.code}", params: {
            link: {
              url: 'http://new_link'
            }
          }, headers: {'Authorization' => response.headers['Authorization']}
        end

        it 'responds not found code' do
          expect(response.status).to eq(404)
        end

        it 'does not update record' do
          created_link.reload
          expect(created_link.url).not_to eq('http://new_link')
        end
      end

      context 'tries to edit his link' do
        before do
          log_in(user)
          put "/links/#{user_link.code}", params: {
            link: {
              url: 'http://new_link'
            }
          }, headers: {'Authorization' => response.headers['Authorization']}
        end

        it 'responds success code' do
          expect(response.status).to eq(200)
        end

        it 'updates record' do
          user_link.reload
          expect(user_link.url).to eq('http://new_link')
        end
      end
    end

    describe 'delete' do
      context 'tries to delete a link that is not his' do
        before do
          log_in(user)
          @count = Link.count
          delete "/links/#{created_link.code}", headers: {'Authorization' => response.headers['Authorization']}
        end

        it 'responds not found' do
          expect(response.status).to eq(404)
        end

        it 'does not delete record' do
          expect(Link.count).to eq(@count)
        end
      end

      context 'tries to delete his link' do
        before do
          log_in(user)
          @count = user.links.count
          delete "/links/#{user_link.code}", headers: {'Authorization' => response.headers['Authorization']}
        end

        it 'responds success code' do
          expect(response.status).to eq(200)
        end

        it 'returns record' do
          expect(response.body).to include(user_link.code)
        end

        it 'deletes record from db' do
          expect(user.links.count).not_to eq(@count)
        end
      end
    end
  end

  context 'when user is not logged in' do
    before do
      get '/links'
    end

    it 'shows unauthorized status' do
      expect(response.status).to eq(401)
    end

    it 'shows you need to login message' do
      expect(response.body).to include('You need to sign in or sign up before continuing')
    end
  end
end
