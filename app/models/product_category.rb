class ProductCategory < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged
  has_closure_tree
end
