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
    
    view.labelInventoryMoneyCount.text = "x \(view.inventory.money)"
    
    view.labelInventoryLemonCount.text = "x \(items.filter({ Lemon().name == $0.name }).count)"
    view.labelPurchaseLemonCount.text = "\(Lemon.toPurchase)"
    
    view.labelInventoryIceCubeCount.text = "x \(items.filter({ IceCube().name == $0.name }).count)"
    view.labelPurchaseIceCubeCount.text = "\(IceCube.toPurchase)"
    
    view.labelInventoryLemonadeRatio.text = getTemperatureFromRatio(view)
    view.labelInventoryLemonadeLiters.text = "\(view.inventory.lemonadeServings)"
    
    view.labelInventoryWeatherDegrees.text = "\(view.inventory.weatherDegrees) °C"
  }
  
  class func getTemperatureFromRatio(view: ViewController) -> String {
    let ratio = view.inventory.lemonadeRatio
    
    if ratio > 0 {
      
      switch ratio {
      case 0.0 ... 0.0999:
        return "Boiling"
      case 0.1 ... 0.1999:
        return "Hot"
      case 0.2 ... 0.2999:
        return "Warm"
      case 0.3 ... 0.3999:
        return "Tepid"
      case 0.4 ... 0.4999:
        return "Ambient"
      case 0.5 ... 0.5999:
        return "Cool"
      case 0.6 ... 0.6999:
        return "Chilly"
      case 0.7 ... 0.7999:
        return "Cold"
      case 0.8 ... 0.8999:
        return "Chilly"
      case 0.9 ... 1.0:
        return "Frosty"
      case 1.1 ... 100:
        return "Frozen"
      default:
        return "Error"
      }
    }
    else {
      return "N/A"
    }
  }
  
  class func showAlertWithText(title: String = "Warning", message: String) {
    
    var alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    
    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
  }
  
  class func mixLemonade (view: ViewController) {
    
    if Lemon.toMix == 0 {
      showAlertWithText(title: Lemon().name, message: "You can´t make lemonade without lemons")
    }
    else if IceCube.toMix == 0 {
      showAlertWithText(title: IceCube().name, message: "You can´t make a refreshing drink without ice!")
    }
    else {
    
      let currentRatio = view.inventory.lemonadeRatio
      let currentServings = view.inventory.lemonadeServings
      let servingsPerLemon = 4
      let newServings = Lemon.toMix * servingsPerLemon
    
      let newRatio:Double = Double(IceCube.toMix) / Double(Lemon.toMix * servingsPerLemon)
      
      let servingsDifference = Double(currentServings / newServings) / Double(10)
      
      if currentServings == 0 {
        view.inventory.lemonadeRatio = newRatio
      }
      else {
        view.inventory.lemonadeRatio += (newRatio - servingsDifference)
      }
        
      Lemon.toMix = 0
      IceCube.toMix = 0
      
      view.inventory.lemonadeServings += newServings
      updateView(view)
    }
  }
  
  class func addToMix <T: Item> (itemType: T.Type, view: ViewController) {
    let currentItem = T()
    
    if finditemsInInventory(itemType, view: view) > 0 {
      itemType.toMix += 1
      removeItemFromInventory(itemType, view: view)
      updateView(view)
    }
    else {
     showAlertWithText(title: currentItem.name, message: "You need to buy more \(currentItem.name)s")
    }
  }
  
  class func addToPurchase <T: Item> (itemType: T.Type, view: ViewController) {
    let currentItem = T()
    
    if (itemType.toPurchase + 1) * currentItem.price <= view.inventory.money {
      itemType.toPurchase += (itemType.toPurchase < 99) ? 1 : 0
      updateView(view)
    }
    else {
      showAlertWithText(title: currentItem.name, message: "You can only afford \(itemType.toPurchase) \(currentItem.name)s")
    }
  }
  
  class func removeFromPurchase <T: Item> (itemType: T.Type, view: ViewController) {
    itemType.toPurchase -= ( itemType.toPurchase > 0) ? 1 : 0
    updateView(view)
  }
  
  class func purchase <T: Item> (itemType: T.Type, view: ViewController) {
    let currentItem = T()
    
    if itemType.toPurchase * currentItem.price <= view.inventory.money {
      
      for _ in 0 ..< itemType.toPurchase {
        addItemToInventory(currentItem, view: view)
        view.inventory.money -= currentItem.price
      }
      itemType.toPurchase = 0
      updateView(view)
    }
    else {
      showAlertWithText(title: currentItem.name, message: "You don´t have enough money to buy \(itemType.toPurchase) \(currentItem.name)s")
    }
  }
  
  class func addItemToInventory (item: Item, view: ViewController) {
    view.inventory.items.append(item)
  }
  
  class func removeItemFromInventory <T: Item> (type: T.Type, view: ViewController) {
    
    for i in 0 ..< view.inventory.items.count {
      if view.inventory.items[i] is T {
        view.inventory.items.removeAtIndex(i)
        break
      }
    }
  }
  
  class func finditemsInInventory <T: Item> (type: T.Type, view: ViewController) -> Int {
    return view.inventory.items.filter { (element: Item) -> Bool in
      element is T
      }.count
  }
  
  
  
  
  
  
  
  





}


