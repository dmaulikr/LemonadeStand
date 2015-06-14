//
//  Helpers.swift
//  LemonStand
//
//  Created by Mattias Lundblad on 2015-06-13.
//  Copyright (c) 2015 Mattias Lundblad. All rights reserved.
//

import UIKit
import Foundation

class Helper {
  
  class func updateView (view: ViewController) {
    
    var items:[Item] = view.inventory.items
    
    view.labelInventoryMoneyCount.text = "$\(view.inventory.money)"
    
    view.labelInventoryLemonCount.text = "\(items.filter({ Lemon().name == $0.name }).count)"
    view.labelPurchaseLemonCount.text = "\(Lemon.toPurchase)"
    
    view.labelInventoryIceCubeCount.text = "\(items.filter({ IceCube().name == $0.name }).count)"
    view.labelPurchaseIceCubeCount.text = "\(IceCube.toPurchase)"
    
    view.labelMixLemonCount.text = "\(view.lemonsToMix)"
    view.labelMixIceCubeCount.text = " \(view.iceCubesToMix)"
  }
  
  class func showAlertWithText(title: String = "Warning", message: String) {
    
    var alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    
    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
  }
  
  class func mix <T: Item> (itemType: T.Type, view: ViewController) {
    
    if finditemsInInventory(itemType, inventory: view.inventory.items) > 0 {
      itemType.toPurchase = 0
      
    }
  }
  
  class func transaction <T: Item> (itemType: T.Type, isSelling: Bool, view: ViewController) {
    
    let currentitem: Item = T()
    
    if isSelling {
      
      if finditemsInInventory(itemType, inventory: view.inventory.items) <= 0 {
        showAlertWithText(title: currentitem.name, message: "You dont have any \(currentitem.name)s")
      }
      else {
        for i in 0 ..< view.inventory.items.count {
          if view.inventory.items[i].name == currentitem.name {
            view.inventory.items.removeAtIndex(i)
            view.inventory.money += currentitem.price
            itemType.toPurchase -= 1
            updateView(view)
            break
          }
        }
      }
    }
    else if view.inventory.money >= currentitem.price {
      
      view.inventory.items.append(currentitem)
      view.inventory.money -= currentitem.price
      itemType.toPurchase += 1
      updateView(view)
    }
    else {
      showAlertWithText(title: currentitem.name, message: "You don´t have enough money")
    }
  }
  
  class func finditemsInInventory <T: Item> (type: T.Type, inventory: [Item]) -> Int {
    return inventory.filter { (element: Item) -> Bool in
      element is T
      }.count
  }
  
  
  
  
  
  
  
  





}


