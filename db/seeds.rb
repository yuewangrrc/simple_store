# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing products
Product.destroy_all

puts "Creating 676 products with faker data..."

676.times do |i|
  Product.create!(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 5.0..200.0),
    stock_quantity: Faker::Number.between(from: 0, to: 150)
  )
  
  # Print progress every 100 products
  puts "Created #{i + 1} products..." if (i + 1) % 100 == 0
end

puts "Seed completed! Total products: #{Product.count}"
