# frozen_string_literal: true

class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged
  has_closure_tree
end
