require 'rails_helper'

describe  Api::LinksController, type: :request do
  # Create users with 10 links each
  let! (:user) { create(:user_with_links) }
  let! (:second_user) { create(:user_with_links, links_count: 5) }

  context 'when user is logged in' do
    describe "index" do
      before do
        log_in(user)
        get '/api/links', headers: {'Authorization' => response.headers['Authorization']}
      end
  
      it 'shows success status' do
        expect(response.status).to eq(200)
      end
  
      it 'returns only user links' do
        expect(json["data"].count).to eq(10)
      end
    end
    
    describe "show" do
      before do
        log_in(user)
        @link = user.links.first
        @link_visits_count = @link.visits.count
        get "/api/links/#{@link.code}", headers: {'Authorization' => response.headers['Authorization']}
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
  end

  context 'when user is not logged in' do
    before do
      get '/api/links'
    end

    it 'shows unauthorized status' do
      expect(response.status).to eq(401)
    end

    it 'shows you need to login message' do
      expect(response.body).to include("You need to sign in or sign up before continuing")
    end
  end
end
