# require "rails_helper"

# RSpec.describe ProductPropertyResource, type: :resource do
# describe "creating" do
# let(:payload) do
# {
# data: {
# type: "product_properties",
# attributes: attributes_for(:product_property),
# },
# }
# end

# let(:instance) do
# ProductPropertyResource.build(payload)
# end

# it "works" do
# expect {
# expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
# }.to change { ProductProperty.count }.by(1)
# end
# end

# describe "updating" do
# let!(:product_property) { create(:product_property) }

# let(:payload) do
# {
# data: {
# id: product_property.id.to_s,
# type: "product_properties",
# attributes: {}, # Todo!
# },
# }
# end

# let(:instance) do
# ProductPropertyResource.find(payload)
# end

# xit "works (add some attributes and enable this spec)" do
# expect {
# expect(instance.update_attributes).to eq(true)
# }.to change { product_property.reload.updated_at }
## .and change { product_property.foo }.to('bar') <- example
# end
# end

# describe "destroying" do
# let!(:product_property) { create(:product_property) }

# let(:instance) do
# ProductPropertyResource.find(id: product_property.id)
# end

# it "works" do
# expect {
# expect(instance.destroy).to eq(true)
# }.to change { ProductProperty.count }.by(-1)
# end
# end
# end
