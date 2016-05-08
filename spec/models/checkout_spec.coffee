describe "Checkout", ->

    beforeEach ->
        @checkout = new Checkout
        @item = new Item 'ITEM', 'item', 10

    describe "attributes", ->

        it "should have a pricingRules {array} attribute", ->
            expect(@checkout.pricingRules.constructor).toEqual(Array)

        it "should have an items {array} attribute", ->
            expect(@checkout.items.constructor).toEqual(Array)

    describe "scan", ->

        it "should add a copy of an item to the items attribute", ->
            @checkout.scan(@item)
            expect(@checkout.items.length).toEqual(1)
            expect(@checkout.items[0]).toEqual(@item)

        it "should return the checkout object (be chainable)", ->
            expect( @checkout.scan(@item) ).toEqual(@checkout)

    describe "total", ->

        it "should return the total of all of the items bought", ->
            @checkout.scan(@item).scan(@item).scan(@item)
            expect( @checkout.total() ).toEqual(30)
