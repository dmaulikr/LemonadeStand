//
//  ViewController.swift
//  LemonStand
//
//  Created by Mattias Lundblad on 2015-06-13.
//  Copyright (c) 2015 Mattias Lundblad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var inventory = Inventory(money: 10, lemons: 0, iceCubes: 0)
  var lemonsToMix = 0
  var iceCubesToMix = 0
  
  @IBOutlet weak var labelInventoryMoneyCount: UILabel!
  @IBOutlet weak var labelInventoryLemonCount: UILabel!
  @IBOutlet weak var labelInventoryIceCubeCount: UILabel!
  
  @IBOutlet weak var labelPurchaseLemonCount: UILabel!
  @IBOutlet weak var labelPurchaseIceCubeCount: UILabel!

  @IBOutlet weak var labelMixLemonCount: UILabel!
  @IBOutlet weak var labelMixIceCubeCount: UILabel!
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Helper.updateView(self)
  }
  
  @IBAction func buttonPurchaseLemonTapped(sender: UIButton) {
    Helper.transaction(Lemon.self, isSelling: false, view: self)
  }
  
  @IBAction func buttonPurchaseIceCubeTapped(sender: UIButton) {
    Helper.transaction(IceCube.self, isSelling: false, view: self)
  }

  @IBAction func buttonUnPurchaseLemonTapped(sender: UIButton) {
    Helper.transaction(Lemon.self, isSelling: true, view: self)
  }
  
  @IBAction func buttonUnPurchaseIceCubeTapped(sender: UIButton) {
    Helper.transaction(IceCube.self, isSelling: true, view: self)
  }

  @IBAction func buttonMixLemonTapped(sender: UIButton) {
  }

  @IBAction func buttonMixIceCubeTapped(sender: UIButton) {
  }

  @IBAction func buttonUnMixLemonTapped(sender: UIButton) {
  }
  
  @IBAction func buttonUnMixIceCubeTapped(sender: UIButton) {
  }
  
  @IBAction func buttonStartDayTapped(sender: UIButton) {
    
    if lemonsToMix == 0 || iceCubesToMix == 0 {
      
      Helper.showAlertWithText(message: "You need atleast one lemon and one ice cube to start the day!")
    }
    else {
      
      let customers:[Customer] = Customer.getCustomers(11)
      println("StartDay:CustomersCount:\(customers.count)")
      
      let lemonadeRatio:Double = Double(lemonsToMix / iceCubesToMix)
      println("StartDay:LemonadeRation:\(lemonadeRatio)")
      
      for customer in customers {
        
        if customer.preference < 0.4 && lemonadeRatio > 1 {
          inventory.money += 1
          println("StartDay:CustomerPurchase:\(customer.name)")
        }
        else if customer.preference > 0.6 && lemonadeRatio < 1 {
          inventory.money += 1
          println("StartDay:CustomerPurchase:\(customer.name)")
        }
        else if customer.preference <= 0.6 && customer.preference >= 0.4 && lemonadeRatio == 1 {
          inventory.money += 1
          println("StartDay:CustomerPurchase:\(customer.name)")
        }
        else {
          println("StartDay:CustomerNoPurchase:\(customer.name)")
        }
      }
    }
    
    
  }
  
  
  
  
  
  
  
  
}

