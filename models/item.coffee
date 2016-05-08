###
# Class for items on sale.
###
class Item

    ###
    # Constructor.
    # code {String}
    # name {String}
    # price {Number}
    ###
    constructor: (@code, @name, @price) ->
        @finalPrice = @price
        @appliedDiscount = null




module.exports = Item
