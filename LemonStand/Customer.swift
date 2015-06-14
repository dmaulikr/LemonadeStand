//
//  Customer.swift
//  LemonStand
//
//  Created by Mattias Lundblad on 2015-06-13.
//  Copyright (c) 2015 Mattias Lundblad. All rights reserved.
//

import Foundation

class Customer {
  
  let name:String
  let preference:Double
  
  init () {
    self.name = Customer.getCustomerName()
    self.preference = Customer.getCustomerPreference()
  }
  
  class func getCustomers(maxAmount:Int) -> [Customer] {
    
    let randomNumber = Int(arc4random_uniform(UInt32(maxAmount)))
    var customerArray:[Customer] = []
    
    for _ in 0 ... randomNumber {
      customerArray.append(Customer())
    }
    return customerArray
  }
  
  class func getCustomerPreference () -> Double {
    return Double(arc4random_uniform(UInt32(101))) / 100
  }
  
  class func getCustomerName () -> String {
    var names:[String] = [
      "Anna",
      "Albert",
      "Beatrice",
      "Boris",
      "Camilla",
      "Carl",
      "David",
      "Danielle",
      "Eric",
      "Emma",
      "Fredric",
      "Fiona",
      "Gerry",
      "Gina",
      "Hanna",
      "Hector",
      "Isaac",
      "Ingrid",
      "John",
      "Joanna",
      "Kimberly",
      "Kyle",
      "Liam",
      "Lisa",
      "Mason",
      "Megan",
      "Nora",
      "Nick",
      "Oliver",
      "Olivia",
      "Peter",
      "Paige",
      "Quinn",
      "Richie",
      "Rowan",
      "Steve",
      "Sophie",
      "Tom",
      "Tilly",
      "Ursula",
      "Viktor",
      "Viola",
      "Xander",
      "Xena",
      "Yasmine",
      "Zack",
      "Zoe"
    ]
    return names[Int(arc4random_uniform(UInt32(names.count)))]
  }

  
  
  
  
  
}
