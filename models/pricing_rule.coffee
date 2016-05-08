###
# Factory class for Pricing Rules of different kinds depending on type parameter.
###
class PricingRule

    ###
    # Constructor.
    # type {String} Type of the discount. Ex: 2x1 or bulk3.
    # itemCode {String} Code of the item this applies to.
    # options {Object} Options are dependent on type of the rule. Specified in inheritor.
    ###
    constructor: (@type, @itemCode, options={}) ->
        if @type.match /^[0-9]x[0-9]$/
            return new FreePricingRule @type, @itemCode
        else if @type.match /^bulk[0-9]+$/
            return new BulkPricingRule @type, @itemCode, options

    ###
    # Traverses list of items and applies discount where appropiate.
    # Main logic goes here. It's just a dummy in the parent but rewritten in inheritors.
    # items {Array} List of all items in checkout.
    ###
    applyDiscount: (items, options) ->




###
# Rules to give away items if certain cuantity of them are bought.
# Rules of type 2x1, 3x2, etc, enter here.
###
class FreePricingRule extends PricingRule

    ###
    # Constructor.
    # type {string} Contains information about the type of discount. Ie: 2x1 or 3x2.
    # itemcode {string} Code of item discount applies to.
    ###
    constructor: (@type, @itemCode) ->
        # In a 2x1 promotion, a is 2 and b is 1.
        @a = Number( @type.split('x')[0] )
        @b = Number( @type.split('x')[1] )

    ###
    # Traverses list of items and applies discount where appropiate.
    # Discount is applied by rewritting finalPrice and appliedDiscount properties of item.
    # items {Array} List of all items.
    ###
    applyDiscount: (items) ->
        count = 0
        for item in items
            if item.code == @itemCode and not item.appliedDiscount
                count += 1
                if count > @b
                    item.finalPrice = 0
                    item.appliedDiscount = @type
                count = 0 if count == @a




###
# Rules to buy in bulk.
# Rules of type "bulk3" enter here.
# Example: all tshirts get a discount price if buyer buys tree or more.
###
class BulkPricingRule extends PricingRule

    ###
    # Constructor.
    # type {string} Contains useful information about the discount. Must be of type "bulkX".
    # itemcode {string} Code of item discount applies to.
    # Available options.
    #   newPrice: {Number} Required. Is the new price all articles get if they cualify for a discount.
    ###
    constructor: (@type, @itemCode, options={}) ->
        throw "newPrice is required with bulk type specials." unless options.newPrice
        @minQuantity = Number( @type.split('bulk')[1] )
        @newPrice = options.newPrice

    ###
    # Traverses list of items and applies discount where appropiate.
    # Discount is applied by rewritting finalPrice and appliedDiscount properties of item.
    # items {Array} List of all items.
    ###
    applyDiscount: (items) ->
        qualifies = (items.filter (item) => item.code == @itemCode).length >= @minQuantity
        if qualifies
            for item in items
                if item.code == @itemCode and not item.appliedDiscount
                    item.finalPrice = @newPrice
                    item.appliedDiscount = @type




module.exports = {PricingRule, FreePricingRule, BulkPricingRule}
