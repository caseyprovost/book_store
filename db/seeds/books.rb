# frozen_string_literal: true

book_category = Category.find_by(name: 'Book')
fantasy_category = Category.find_by(name: 'Sci-Fi/Fantasy')

the_ghost_king = FactoryBot.create(:product, name: 'The Ghost King')
the_ghost_king.categories << book_category
the_ghost_king.categories << fantasy_category

the_ghost_king.product_properties.create!(
  property: Property.find_by(name: 'book-series'),
  value: 'Transitions #3'
)

the_ghost_king.product_properties.create!(
  property: Property.find_by(name: 'language'),
  value: 'English'
)

the_ghost_king.product_properties.create!(
  property: Property.find_by(name: 'publisher'),
  value: 'ABC Publishing'
)

the_ghost_king.product_properties.create!(
  property: Property.find_by(name: 'page-count'),
  value: '250'
)

book_format = OptionType.find_by(name: 'Book Format')
Product.joins(product_properties: [:property]).where(properties: { name: 'book-series' }).each do |book|
  FactoryBot.create(:variant,
    product: book,
    name: "#{book.name} - Hard Cover",
    price: 40.00,
    position: 1
   )

  FactoryBot.create(:variant,
    product: book,
    name: "#{book.name} - Paperback",
    price: 20.00,
    position: 2
   )

  ebook = FactoryBot.create(:variant,
    product: book,
    name: "#{book.name} - ebook",
    price: 10.00,
    position: 3
   )

  book_format.option_values.each do |option_value|
    FactoryBot.create(:option_value_variant, option_value: option_value, variant: ebook)
  end
end
