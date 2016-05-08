###
# Special cases as given in coding challenge.
#
# Given items are:
#   'VOUCHER', 'Cabify Voucher', 5
#   'TSHIRT', 'Cabify T-Shirt', 20
#   'MUG', 'Cabify coffee Mug', 7.5
# Pricing rules are:
#   '2x1', 'VOUCHER'
#   'bulk3', 'TSHIRT', newPrice:19
###

describe "Checkout#total", ->

    beforeEach ->
        @voucher = new Item 'VOUCHER', 'Cabify Voucher', 5
        @tshirt = new Item 'TSHIRT', 'Cabify T-Shirt', 20
        @mug = new Item 'MUG', 'Cabify coffee Mug', 7.5
        @pricingRules = [
          new PricingRule '2x1', 'VOUCHER'
          new PricingRule 'bulk3', 'TSHIRT', newPrice:19
        ]
        @checkout = new Checkout @pricingRules


    describe "Items bought are VOUCHER, TSHIRT, MUG.", ->

        beforeEach ->
            @checkout.scan(@voucher).scan(@tshirt).scan(@mug)

        it "should return a total of €32.50", ->
            expect( @checkout.total() ).toEqual(32.50)

    describe "Items bought are VOUCHER, TSHIRT, VOUCHER.", ->

        beforeEach ->
            @checkout.scan(@voucher).scan(@tshirt).scan(@voucher)

        it "should return a total of €25.00", ->
            expect( @checkout.total() ).toEqual(25.00)

    describe "Items bought are TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT.", ->

        beforeEach ->
            @checkout.scan(@tshirt).scan(@tshirt).scan(@tshirt).scan(@voucher).scan(@tshirt)

        it "should return a total of €81.00", ->
            expect( @checkout.total() ).toEqual(81.00)

    describe "Items bought are VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT.", ->

        beforeEach ->
            @checkout.scan(@voucher).scan(@tshirt).scan(@voucher).scan(@voucher).scan(@mug).scan(@tshirt).scan(@tshirt)

        it "should return a total of €74.50", ->
            expect( @checkout.total() ).toEqual(74.50)
