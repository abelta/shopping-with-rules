###
# Class for items on sale.
# param code {String}
# param name {String}
# param price {Number}
###
class Item

    constructor: (@code, @name, @price) ->
        @finalPrice = @price
        @appliedDiscount = null



module.exports = Item
