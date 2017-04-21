//
//  CartItmes.swift
//  BCO
//
//  Created by Abhishek Kavalla on 4/12/17.
//  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
//

import Foundation
import Parse
import Bolts
class CartItems:PFObject {
    @NSManaged var item_name:String
    @NSManaged var quantity:Int
    @NSManaged var price:Int
    @NSManaged var pickupTime:String
    
    
    
    init(item_name:String,quantity:Int,price:Int,pickupTime:String) {
        super.init()
        self.item_name = item_name
        self.quantity = quantity
        self.price = price
        self.pickupTime = pickupTime
        
    }
    
    override init() {
        super.init()
    }
    
    override class func query() -> PFQuery<PFObject>? {
        let query = PFQuery(className: CartItems.parseClassName())
        query.includeKey("user")
        return query
    }
}
extension CartItems : PFSubclassing {
    
    class func parseClassName() -> String {
        return "Cart"
    }
}
