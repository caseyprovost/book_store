# frozen_string_literal: true

book_format = FactoryBot.create(:option_type, name: 'Book Format')
FactoryBot.create(:option_value, option_type: book_format, name: 'PDF', position: 2)
FactoryBot.create(:option_value, option_type: book_format, name: 'ePub', position: 1)
FactoryBot.create(:option_value, option_type: book_format, name: 'Kindle', position: 3)
