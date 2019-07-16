# frozen_string_literal: true

require "rails_helper"

RSpec.describe "categories#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/admin/api/v1/categories", payload
  end

  describe "basic create" do
    let(:payload) do
      {
        data: {
          type: "categories",
          attributes: attributes_for(:category),
        },
      }
    end

    it "works" do
      expect(Admin::CategoryResource).to receive(:build).and_call_original
      expect {
        make_request
      }.to change { Category.count }.by(1)
      category = Category.last
      expect(response.status).to eq(201)
    end
  end
end
