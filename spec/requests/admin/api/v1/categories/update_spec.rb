# frozen_string_literal: true

require "rails_helper"

describe "updating" do
  let!(:category) { create(:category) }

  let(:payload) do
    {
      data: {
        id: category.id.to_s,
        type: "categories",
        attributes: {name: "testing 123"},
      },
    }
  end

  let(:instance) do
    CategoryResource.find(payload)
  end

  it "works" do
    expect {
      expect(instance.update_attributes).to eq(true)
    }.to change { category.reload.updated_at }
      .and change { category.name }.to("testing 123")
  end
end
