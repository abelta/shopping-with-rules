describe "PricingRule", ->

    beforeEach ->
        @pricingRule = new PricingRule 'type', 'ITEMCODE'

    describe "factory constructor", ->

        describe "type is of kind '2x1'", ->

            it "should return a FreePricingRule", ->
                rule = new PricingRule '2x1', 'ITEMCODE'
                expect(rule.constructor).toBe(FreePricingRule)

        describe "type is of kind 'bulk4'", ->

            it "should return a BulkPricingRule", ->
                rule = new PricingRule 'bulk4', 'ITEMCODE', {newPrice: 10}
                expect(rule.constructor).toBe(BulkPricingRule)

    describe "attributes", ->

        it "should have a type {String} attibute", ->
            expect(typeof @pricingRule.type).toBe('string')

        it "should have a itemCode {String} attribute", ->
            expect(typeof @pricingRule.itemCode).toBe('string')




describe "FreePricingRule", ->

    beforeEach ->
        this.freePricingRule = new PricingRule '3x2', 'CODE'

    describe "attributes", ->

        it "should take an 'a' attribute from type", ->
            expect(@freePricingRule.a).toEqual(3)

        it "should take a 'b' attribute from type", ->
            expect(@freePricingRule.b).toEqual(2)

    describe "applyDiscount", ->

        describe "items qualify for discount", ->

            it "should apply a discount", ->
                # Enough items to apply for discount.
                items = [
                    new Item('CODE', 'test item', 10)
                    new Item('CODE', 'test item', 10)
                    new Item('CODE', 'test item', 10)
                ]
                @freePricingRule.applyDiscount(items)
                expect(items[2].finalPrice).toEqual(0)
                expect(items[2].appliedDiscount).toEqual('3x2')

        describe "items don't qualify for a discount", ->

            it "should not apply a discount", ->
                # Not enough items to apply for discount.
                items = [
                    new Item('CODE', 'test item', 10)
                    new Item('CODE', 'test item', 10)
                ]
                @freePricingRule.applyDiscount(items)
                for item in items
                    expect(item.finalPrice).toEqual(item.price)
                    expect(item.appliedDiscount).toBe(null)
                



describe "BulkPricingRule", ->

    beforeEach ->
        @bulkPricingRule = new PricingRule 'bulk3', 'CODE', newPrice: 4

    describe "attributes", ->

        it "should throw an error if no options.newPrice is provided", ->
            expect(-> new PricingRule 'bulk3', 'CODE').toThrow()

        it "should take a minQuantity attribute from type", ->
            expect(@bulkPricingRule.minQuantity).toEqual(3)

        it "should take a newPrice attribute from options.newPrice", ->
            expect(@bulkPricingRule.newPrice).toEqual(4)

    describe "applyDiscount", ->

        describe "items qualify for a discount", ->

            it "should apply a discount", ->
                items = [
                    new Item('CODE', 'test item', 10)
                    new Item('CODE', 'test item', 10)
                    new Item('CODE', 'test item', 10)
                ]
                @bulkPricingRule.applyDiscount(items)
                for item in items
                    expect(item.finalPrice).toEqual(4)
                    expect(item.appliedDiscount).toBe('bulk3')

        describe "items don't qualify for a discount", ->

            it "should not apply a discount", ->
                items = [
                    new Item('CODE', 'test item', 10)
                    new Item('CODE', 'test item', 10)
                ]
                @bulkPricingRule.applyDiscount(items)
                for item in items
                    expect(item.finalPrice).toEqual(item.price)
                    expect(item.appliedDiscount).toBe(null)
