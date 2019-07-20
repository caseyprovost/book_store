# require "rails_helper"

# RSpec.describe ProductOptionTypeResource, type: :resource do
# describe "creating" do
# let(:payload) do
# {
# data: {
# type: "product_option_types",
# attributes: attributes_for(:product_option_type),
# },
# }
# end

# let(:instance) do
# ProductOptionTypeResource.build(payload)
# end

# it "works" do
# expect {
# expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
# }.to change { ProductOptionType.count }.by(1)
# end
# end

# describe "updating" do
# let!(:product_option_type) { create(:product_option_type) }

# let(:payload) do
# {
# data: {
# id: product_option_type.id.to_s,
# type: "product_option_types",
# attributes: {}, # Todo!
# },
# }
# end

# let(:instance) do
# ProductOptionTypeResource.find(payload)
# end

# xit "works (add some attributes and enable this spec)" do
# expect {
# expect(instance.update_attributes).to eq(true)
# }.to change { product_option_type.reload.updated_at }
## .and change { product_option_type.foo }.to('bar') <- example
# end
# end

# describe "destroying" do
# let!(:product_option_type) { create(:product_option_type) }

# let(:instance) do
# ProductOptionTypeResource.find(id: product_option_type.id)
# end

# it "works" do
# expect {
# expect(instance.destroy).to eq(true)
# }.to change { ProductOptionType.count }.by(-1)
# end
# end
# end
