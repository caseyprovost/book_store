# frozen_string_literal: true

book_category = FactoryBot.create(:category, name: 'Book')
book_category.children.create(name: 'Sci-Fi/Fantasy')
