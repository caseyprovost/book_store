# frozen_string_literal: true

# create the default properties for books
[
  { name: 'book-series' },
  { name: 'language' },
  { name: 'dimensions' },
  { name: 'shipping-weight' },
  { name: 'book-binding' },
  { name: 'page-count' }
].each do |data|
  Property.find_or_create_by(data)
end
