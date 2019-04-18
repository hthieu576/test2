# test2

## Take home Ruby exercise.

* Note: it’s recommended that you complete the exercise in Ruby. However, if you do not know Ruby yet and a much stronger in another language, you can choose that language.

* Our client is an online marketplace, here is a sample of some of the products available on our site:

```
Product code  | Name                   | Price
----------------------------------------------------------
001           | Lavender heart         | £9.25
002           | Personalised cufflinks | £45.00
003           | Kids T-shirt           | £19.95
```

* This is just an example of products, your system should be ready to accept any kind of product.

* Our marketing team want to offer promotions as an incentive for our customers to purchase these items.
* If you spend over £60, then you get 10% off of your purchase. If you buy 2 or more lavender hearts then the price drops to £8.50.
* Our check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.

* The interface to our checkout looks like this (shown in Ruby):
```
co = Checkout.new(promotional_rules)
co.scan(item)
co.scan(item)
price = co.total
```


* Implement a checkout system that fulfills these requirements. Do this outside of any frameworks. We’re looking for candidates to demonstrate their knowledge of TDD.

## Test result sample.
---------
```
Basket: 001,002,003
Total price expected: £66.78

Basket: 001,003,001
Total price expected: £36.95

Basket: 001,002,001,003
Total price expected: £73.76
```
-------------------------------------------
## prepare data for testing.
---------
```
rails db:create && rails db:migrate
```

## run seed data.
---------
```
rails db:seed
```

## How to test.

* Step 1: Run command from project dir.
```
irb -I . -r lib/checkout.rb
```
* Step 2: Run command.
```
Checkout.new(order_id, promotional_rules).call
```

* For example: we'll checkout order with id = 1 and promotion_rules like this.

```
order_id = 1
promotional_rule = {
  total: {
    min_amount: 60,
    discount_percent: 10
  },
  products: {
    '001' => {
      min_quantity: 2,
      price_discount: 8.5
    }
  }
}
```
* We'll run command.
```
Checkout.new(order_id=1, Promotion::RULES).call
```

* expected result
```
{ basket: '001, 002, 003', total_price_expected: '£66.78' }
```
