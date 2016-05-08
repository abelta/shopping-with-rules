###
# MAIN.
# Test use as described in coding challenge.
###

Checkout = require './models/checkout.coffee'
Item = require './models/item.coffee'
{PricingRule, FreePricingRule, BulkPricingRule} = require './models/pricing_rule.coffee'

voucher = new Item 'VOUCHER', 'Cabify Voucher', 5
tshirt = new Item 'TSHIRT', 'Cabify T-Shirt', 20
mug = new Item 'MUG', 'Cabify coffee Mug', 7.5


pricingRules = [
  new PricingRule '2x1', 'VOUCHER'
  new PricingRule 'bulk3', 'TSHIRT', newPrice:19
]


console.log "Items: VOUCHER, TSHIRT, MUG."
co = new Checkout(pricingRules)
co.scan(voucher).scan(tshirt).scan(mug)
co.total(withPrint: true)
console.log "(Should be €32.50)"

console.log()
console.log()

console.log "Items: VOUCHER, TSHIRT, VOUCHER."
co = new Checkout(pricingRules)
co.scan(voucher).scan(tshirt).scan(voucher)
co.total(withPrint: true)
console.log "(Should be €25.00)"

console.log()
console.log()

console.log "Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT."
co = new Checkout(pricingRules)
co.scan(tshirt).scan(tshirt).scan(tshirt).scan(voucher).scan(tshirt)
co.total(withPrint: true)
console.log "(Should be €81.00)"

console.log()
console.log()

console.log "Items: VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT."
co = new Checkout(pricingRules)
co.scan(voucher).scan(tshirt).scan(voucher).scan(voucher).scan(mug).scan(tshirt).scan(tshirt)
co.total(withPrint: true)
console.log "(Should be €74.50)"
