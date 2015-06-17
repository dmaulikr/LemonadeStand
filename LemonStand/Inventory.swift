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
  var lemonadeRatio: Double
  var lemonadeServings: Int
  var weatherDegrees: Int
  
  init () {
    money = 0
    items = []
    lemonadeServings = 0
    lemonadeRatio = 0
    weatherDegrees = 0
  }
  
  init (money:Int, lemons:Int, iceCubes:Int) {
    self.money = money
    self.items = []
    self.lemonadeServings = 0
    self.lemonadeRatio = 0.0
    self.weatherDegrees = 0
    
    for _ in 0 ..< lemons {
      self.items.append(Lemon())
    }
    
    for _ in 0 ..< iceCubes {
      self.items.append(IceCube())
    }
  }
  
  func randomizeWeather () -> Int {
    return Int(arc4random_uniform(UInt32(15)) + 20)
  }
}