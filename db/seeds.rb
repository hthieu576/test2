# frozen_string_literal: true

# Create User
user = User.create!(first_name: 'hieu', last_name: 'hoang trung', email: 'abc@gmail.com', address: 'hcm')

# Create Orders
order_1st = Order.create!(user_id: user.id, status: 'ordered', comment: 'case 1')
order_2nd = Order.create!(user_id: user.id, status: 'ordered', comment: 'case 2')
order_3rd = Order.create!(user_id: user.id, status: 'ordered', comment: 'case 3')

# Create Products
Product.create!(order_id: order_1st.id, code: '001', name: 'Lavender heart', price: 9.25)
Product.create!(order_id: order_1st.id, code: '002', name: 'Personalised cufflinks', price: 45.00)
Product.create!(order_id: order_1st.id, code: '003', name: 'Kids T-shirt', price: 19.95)

Product.create!(order_id: order_2nd.id, code: '001', name: 'Lavender heart', price: 9.25)
Product.create!(order_id: order_2nd.id, code: '003', name: 'Kids T-shirt', price: 19.95)
Product.create!(order_id: order_2nd.id, code: '001', name: 'Lavender heart', price: 9.25)

Product.create!(order_id: order_3rd.id, code: '001', name: 'Lavender heart', price: 9.25)
Product.create!(order_id: order_3rd.id, code: '002', name: 'Personalised cufflinks', price: 45.00)
Product.create!(order_id: order_3rd.id, code: '001', name: 'Lavender heart', price: 9.25)
Product.create!(order_id: order_3rd.id, code: '003', name: 'Kids T-shirt', price: 19.95)
