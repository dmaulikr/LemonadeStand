//
//  Inventory.swift
//  LemonStand
//
//  Created by Mattias Lundblad on 2015-06-13.
//  Copyright (c) 2015 Mattias Lundblad. All rights reserved.
//

import Foundation

struct Inventory {
  
  var money:Int
  var items:[Item]
  
  init () {
    money = 0
    items = []
  }
  
  init (money:Int, lemons:Int, iceCubes:Int) {
    self.money = money
    self.items = []
    
    for _ in 0 ..< lemons {
      self.items.append(Lemon())
    }
    
    for _ in 0 ..< iceCubes {
      self.items.append(IceCube())
    }
  }
}