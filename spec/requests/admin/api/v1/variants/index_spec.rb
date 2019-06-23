require 'rails_helper'

RSpec.describe "variants#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/admin/api/v1/variants", params: params
  end

  describe 'basic fetch' do
    let!(:variant1) { create(:variant) }
    let!(:variant2) { create(:variant) }

    it 'works' do
      expect(VariantResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['variants'])
      expect(d.map(&:id)).to match_array([variant1.id, variant2.id])
    end
  end
end
