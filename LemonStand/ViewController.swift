//
//  ViewController.swift
//  LemonStand
//
//  Created by Mattias Lundblad on 2015-06-13.
//  Copyright (c) 2015 Mattias Lundblad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var sales = 0
  var customers: [Customer] = []
  var inventory = Inventory(money: 10, lemons: 0, iceCubes: 0)
  
  let draggableLemonImage = UIImageView(image: UIImage(named: "lemonIcon"))
  let draggableIceCubeImage = UIImageView(image: UIImage(named: "iceCubeIcon"))
  
  @IBOutlet weak var imageViewLemon: UIImageView!
  @IBOutlet weak var imageViewIceCube: UIImageView!
  
  @IBOutlet weak var labelInventoryWeatherDegrees: UILabel!
  @IBOutlet weak var imageViewLemonadeJar: UIImageView!
  @IBOutlet weak var labelInventoryMoneyCount: UILabel!
  @IBOutlet weak var labelInventoryLemonCount: UILabel!
  @IBOutlet weak var labelInventoryIceCubeCount: UILabel!
  @IBOutlet weak var labelInventoryLemonadeRatio: UILabel!
  @IBOutlet weak var labelInventoryLemonadeLiters: UILabel!
  
  @IBOutlet weak var labelPurchaseLemonCount: UILabel!
  @IBOutlet weak var labelPurchaseIceCubeCount: UILabel!
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    inventory.weatherDegrees = inventory.randomizeWeather()
    
    draggableLemonImage.frame = imageViewLemon.frame
    draggableIceCubeImage.frame = imageViewIceCube.frame
    
    Helper.updateView(self)
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    super.touchesBegan(touches, withEvent: event)
    
    let touchInput = touches.first as! UITouch
    
    if imageViewLemon.frame.contains(touchInput.locationInView(self.view)) {
      Lemon.isDragging = true
      self.view.addSubview(draggableLemonImage)
      draggableLemonImage.center = imageViewLemon.center
    }
    else {
      Lemon.isDragging = false
    }
    
    if imageViewIceCube.frame.contains(touchInput.locationInView(self.view)) {
      IceCube.isDragging = true
      self.view.addSubview(draggableIceCubeImage)
      draggableIceCubeImage.center = imageViewIceCube.center
    }
    else {
      IceCube.isDragging = false
    }
  }
  
  override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    super.touchesMoved(touches, withEvent: event)
    
    let touchInput = touches.first as! UITouch
    
    if Lemon.isDragging {
      draggableLemonImage.center = touchInput.locationInView(self.view)
    }
    else if IceCube.isDragging {
      draggableIceCubeImage.center = touchInput.locationInView(self.view)
    }
  }
  
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    super.touchesEnded(touches, withEvent: event)
    
    if imageViewLemonadeJar.frame.contains((touches.first as! UITouch).locationInView(self.view)) && (Lemon.isDragging || IceCube.isDragging) {
      
      if Lemon.isDragging {
        Helper.addToMix(Lemon.self, view: self)
      } else if IceCube.isDragging {
        Helper.addToMix(IceCube.self, view: self)
      }
    }
    
    Lemon.isDragging = false
    IceCube.isDragging = false
    
    draggableLemonImage.removeFromSuperview()
    draggableIceCubeImage.removeFromSuperview()
  }
  
  @IBAction func buttonHelpPressed(sender: UIButton) {
    Helper.showAlertWithText(title: "How to Play!", message: "Buy lemons and ice cubes then mix them into refreshing lemonade! \n\n If the weather is nice you are likley to get more customers. \n\n If it is cold outisde the customers probably don't want alot of ice.")
  }
  
  @IBAction func buttonAddLemonToPurchasePressed(sender: UIButton) {
    Helper.addToPurchase(Lemon.self, view: self)
  }
  
  @IBAction func buttonRemoveLemonToPurchasePressed(sender: UIButton) {
    Helper.removeFromPurchase(Lemon.self, view: self)
  }
  
  @IBAction func buttonPurchaseLemonsPressed(sender: UIButton) {
    Helper.purchase(Lemon.self, view: self)
  }
  
  @IBAction func buttonAddIceCubeToPurchasePressed(sender: UIButton) {
    Helper.addToPurchase(IceCube.self, view: self)
  }
  
  @IBAction func buttonRemoveIceCubeToPurchasePressed(sender: UIButton) {
    Helper.removeFromPurchase(IceCube.self, view: self)
  }
  
  @IBAction func buttonPurchaseIceCubesPressed(sender: UIButton) {
    Helper.purchase(IceCube.self, view: self)
  }
  
  @IBAction func buttonMixLemonadePressed(sender: UIButton) {
    Helper.mixLemonade(self)
  }
  
  @IBAction func buttonStartDayPressed(sender: UIButton) {
    
    if inventory.lemonadeServings <= 0 {
      
      Helper.showAlertWithText(message: "You need to mix some Lemonade first!")
    }
    else {
      
      let degreesVisitRatio = inventory.weatherDegrees - 25
      let degreesPreferenceRatio = Double(inventory.weatherDegrees - 25) / 100
      
      customers = Customer.getCustomers(10 + degreesVisitRatio)
      
      for customer in customers  {
        
        let preference: Double = customer.preference + degreesPreferenceRatio
        
        if (preference < (inventory.lemonadeRatio + 0.1)) && (preference > (inventory.lemonadeRatio - 0.1)) {
          if inventory.lemonadeServings != 0 {
            customer.didBuy = true
            inventory.money += 1
            inventory.lemonadeServings -= 1
            sales += 1
          }
        }
      }
      self.performSegueWithIdentifier("showReport", sender: self)
    }    
  }
  
  
  
  
  
  
  
  
}