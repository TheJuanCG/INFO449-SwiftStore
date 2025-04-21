//
//  main.swift
//  Store
//
//  Created by Ted Neward on 2/29/24.
//

import Foundation

protocol SKU {
    // name of item and require get
    var name: String { get }
    
    // Gets price in USD Pennies
    func price() -> Int
}

class Item: SKU, Hashable, Equatable {
    private var _name: String
    
    var name: String {
        get {return _name}
    }
    
    private var priceEach: Int;
    
    init(name: String, priceEach: Int) {
        // What should we do if price is negative?
        // I say if number is negative then we just set it to 0
        self._name = name
        self.priceEach = max(priceEach, 0)

    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.price() == rhs.price()
    }

    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(price())
    }
    
    func price() -> Int { return priceEach }
    
}

class Receipt {
    // What if you have multiple of SKUs?
    // Can get the item name from skus
    var itemsList: [Item]
    private var itemFreq: [Item: Int]
    
    init() {
        self.itemsList = []
        self.itemFreq = [:]
    }
    
    // Return list of skus
    func items() -> [Item] {
        return itemsList
    }
    
    func add(item: Item) {
        itemsList.append(item)
        itemFreq[item, default: 0] += 1
    }
    
    func total() -> Int {
        var sum = 0
        for item in itemsList {
            sum += item.price()
        }
        
        return sum
    }
    
    func output() -> String {
        var res = "Receipt:\n"
        for item in itemsList {
            let dollars = item.price() / 100
            let cents = item.price() % 100
            let formatted = String(format: "$%d.%02d", dollars, cents)
            
            res += "\(item.name): \(formatted)\n"
        }
        
        res += "------------------\n"
        let totalDollars = total() / 100
        let cents = total() % 100
        let formatted = String(format: "$%d.%02d", totalDollars, cents)
        
        res += "TOTAL: \(formatted)"
        return res
    }
}

class Register {
    var receipt: Receipt
    
    init() {
        self.receipt = Receipt()
    }
    
    func scan(_ item: Item) {
        receipt.add(item: item);
    }
    
    // TO-DO: Return current total of all items
    // need to implement receipt first
    func subtotal() -> Int {
        
        return receipt.total()
    }
    
    // TO-DO: Return receipt and clears its state
    func total() -> Receipt {
        let res = receipt
        receipt = Receipt()
        
        return res
    }

}

class Store {
    let version = "0.1"
    func helloWorld() -> String {
        return "Hello world"
    }
    
}

