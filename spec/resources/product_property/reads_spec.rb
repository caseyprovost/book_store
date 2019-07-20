# require "rails_helper"

# RSpec.describe ProductPropertyResource, type: :resource do
# describe "serialization" do
# let!(:product_property) { create(:product_property) }

# it "works" do
# render
# data = jsonapi_data[0]
# expect(data.id).to eq(product_property.id)
# expect(data.jsonapi_type).to eq("product_properties")
# end
# end

# describe "filtering" do
# let!(:product_property1) { create(:product_property) }
# let!(:product_property2) { create(:product_property) }

# context "by id" do
# before do
# params[:filter] = {id: {eq: product_property2.id}}
# end

# it "works" do
# render
# expect(d.map(&:id)).to eq([product_property2.id])
# end
# end
# end

# describe "sorting" do
# describe "by id" do
# let!(:product_property1) { create(:product_property) }
# let!(:product_property2) { create(:product_property) }

# context "when ascending" do
# before do
# params[:sort] = "id"
# end

# it "works" do
# render
# expect(d.map(&:id)).to eq([
# product_property1.id,
# product_property2.id,
# ])
# end
# end

# context "when descending" do
# before do
# params[:sort] = "-id"
# end

# it "works" do
# render
# expect(d.map(&:id)).to eq([
# product_property2.id,
# product_property1.id,
# ])
# end
# end
# end
# end

# describe "sideloading" do
## ... your tests ...
# end
# end
