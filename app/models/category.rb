# frozen_string_literal: true

class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged
  has_closure_tree

  has_many :product_categories
  has_many :products, through: :product_categories
end
