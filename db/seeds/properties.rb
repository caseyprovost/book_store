# frozen_string_literal: true

# create the default properties for books
[
  { name: 'book-series', presentation: 'Series' },
  { name: 'language', presentation: 'Language' },
  { name: 'publisher', presentation: 'Publisher' },
  { name: 'page-count', presentation: 'Page count' }
].each do |data|
  Property.find_or_create_by(data).save!
end
