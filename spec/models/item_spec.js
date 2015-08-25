describe('Item', function(){
    
    beforeEach(function(){
        var item = new Item('TESTITEM', 'Test item', 10);
    });

    it("is true", function(){
        expect(true).toBe(true);
    });

    it("has a code {string} attribute", function(){
        expect(typeof item.code).toBe('string');
    });

});
