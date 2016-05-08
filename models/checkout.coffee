###
# Class for the checkout event.
###
class Checkout

    ###
    # Constructor.
    # pricingRules {Array} An array of applicable pricing rules.
    ###
    constructor: (@pricingRules=[]) ->
        @items = []

    ###
    # Adds an item to the list of items to be bought.
    # item {Item}
    # return {Checkout}. It's a chainable method.
    ###
    scan: (item) ->
        clone = (obj) -> JSON.parse( JSON.stringify(obj) )
        @items.push clone(item)
        return this

    ###
    # Returns total and renders result if option "withPrint" is selected.
    # Only one discount per item.
    # Available options
    #     withPrint: (default false). Outputs a print copy of the receipt.
    # return {Number} Total spent after discounts applied.
    ###
    total: (options={}) ->
        sumTotal = (sum, item) ->
            if options.withPrint
                discountType = if item.appliedDiscount then " (#{item.appliedDiscount})" else ""
                console.log "#{item.name} - #{item.finalPrice.toFixed(2)}" + discountType
            sum + item.finalPrice

        rule.applyDiscount(@items) for rule in @pricingRules
        result = @items.reduce(sumTotal, 0)
        console.log "Total: €#{result.toFixed(2)}" if options.withPrint
        result
        



module.exports = Checkout
