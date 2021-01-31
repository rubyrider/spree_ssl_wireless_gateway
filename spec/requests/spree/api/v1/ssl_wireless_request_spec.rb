require 'rails_helper'

RSpec.describe "Spree::Api::V1::SslWirelesses", type: :request do

  describe "GET /initiate" do
    it "returns http success" do
      get "/spree/api/v1/ssl_wireless/initiate"
      expect(response).to have_http_status(:success)
    end
  end

end
