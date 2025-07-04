# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'csv'

# Clear existing data
puts "Clearing existing data..."
Product.destroy_all
Category.destroy_all

puts "Loading products and categories from CSV file..."

# Read and process the CSV file
csv_file_path = Rails.root.join('db', 'products.csv')
csv_data = CSV.read(csv_file_path, headers: true)

# Create categories first (to avoid duplicates)
category_names = csv_data.map { |row| row['category'] }.uniq
categories = {}

puts "Creating categories..."
category_names.each do |category_name|
  category = Category.create!(name: category_name)
  categories[category_name] = category
  puts "Created category: #{category_name}"
end

puts "\nCreating products..."
created_count = 0

csv_data.each do |row|
  category = categories[row['category']]
  
  product = Product.create!(
    title: row['name'],
    description: row['description'],
    price: row['price'].to_f,
    stock_quantity: row['stock quantity'].to_i,
    category: category
  )
  
  created_count += 1
  puts "Created product #{created_count}: #{product.title}" if created_count % 50 == 0
end

puts "\nSeed completed!"
puts "Categories created: #{Category.count}"
puts "Products created: #{Product.count}"

# Display category breakdown
puts "\nProducts by category:"
Category.all.each do |category|
  puts "  #{category.name}: #{category.products.count} products"
end
