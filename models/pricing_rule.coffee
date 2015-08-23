###
# Factory class for Pricing Rules of different kinds depending on type parameter.
# param type {String} - Type of the discount. Ex: 2x1 or bulk3.
# param itemCode {String} - Code of the item this applies to.
# param options {Object} - Options are dependent on type of the rule.
###
class PricingRule

    constructor: (@type, @itemCode, options={}) ->
        if @type.match /^[0-9]x[0-9]$/
            return new FreePricingRule type, itemCode, options
        else if @type.match /^bulk[0-9]+$/
            return new BulkPricingRule type, itemCode, options

    ###
    # Apply discount to a list of items.
    # param items {Array} - List of all items in checkout.
    ###
    applyDiscount: (items, options) ->




###
# Rules to give away items if certain cuantity of them are bought.
# Rules of type "2x1" enter here.
###
class FreePricingRule extends PricingRule

    constructor: (@type, @itemCode, options={}) ->
        # In a 2x1 promotion, a is 2 and b is 1.
        @a = Number( @type.split('x')[0] )
        @b = Number( @type.split('x')[1] )

    applyDiscount: (items) ->
        count = 0
        for item in items
            if item.code == @itemCode and not item.appliedDiscount
                count += 1
                if count > @b
                    item.finalPrice = 0
                    item.appliedDiscount = @type
                count = 0 if count == @a
        true




###
# Rules to buy in bulk.
# Rules of tipe "bulk3" are created here.
# Example: all tshirts get a discount price if buyer buys tree or more.
# Available options.
#   newPrice: {Number} Required. Is the new price all articles get if they cualify for a discount.
###
class BulkPricingRule extends PricingRule

    constructor: (@type, @itemCode, options={}) ->
        throw "newPrice is required with bulk type specials." unless options.newPrice
        @minCuantity = Number( @type.split('bulk')[1] )
        @newPrice = options.newPrice

    applyDiscount: (items) ->
        cualifies = (items.filter (item) => item.code == @itemCode).length >= @minCuantity
        if cualifies
            for item in items
                if item.code == @itemCode and not item.appliedDiscount
                    item.finalPrice = @newPrice
                    item.appliedDiscount = @type





module.exports = PricingRule
