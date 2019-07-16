# frozen_string_literal: true

require "rails_helper"

RSpec.describe "categories#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/categories/#{category.id}", params: params
  end

  describe "basic fetch" do
    let!(:category) { create(:category) }

    it "works" do
      expect(CategoryResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("categories")
      expect(d.id).to eq(category.id)
    end
  end
end
