describe 'Item', ->
    
    beforeEach ->
        @item = new Item 'TESTITEM', 'Test item', 10
    
    describe "attributes", ->

        it "has a code {string} attribute", ->
            expect(typeof @item.code).toBe('string')

        it "has a name {string} attribute", ->
            expect(typeof @item.name).toBe('string')

        it "has a price {number} attribute", ->
            expect(typeof @item.price).toBe('number')

        it "has a finalPrice {number} attribute", ->
            expect(typeof @item.finalPrice).toBe('number')

        it "has a appliedDiscount {null} attribute", ->
            expect(@item.appliedDiscount).toBe(null)

    describe 'finalPrice', ->

        it "is originally the same as price", ->
            expect(@item.finalPrice).toEqual(@item.price)
