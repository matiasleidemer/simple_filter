class Product < ActiveRecord::Base
  scope :active, -> { where active: true }
  scope :inactive, -> { where active: false }
  scope :with_name, -> (name) { where 'products.name like ?', "%#{name}%" }
end

Product.create!(name: 'Book', price: 2.99, start_at: DateTime.now, end_at: DateTime.now + 7, active: true)
Product.create!(name: 'Pen', price: 26.49, start_at: DateTime.now, end_at: DateTime.now + 6, active: false)
Product.create!(name: 'Notebook', price: 48.99, start_at: DateTime.now, end_at: DateTime.now + 5, active: true)
Product.create!(name: 'Mouse', price: 51.49, start_at: DateTime.now, end_at: DateTime.now + 4, active: true)
