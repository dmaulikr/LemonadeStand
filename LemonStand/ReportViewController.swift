//
//  ReportViewController.swift
//  LemonStand
//
//  Created by Mattias Lundblad on 2015-06-16.
//  Copyright (c) 2015 Mattias Lundblad. All rights reserved.
//

import Foundation
import UIKit

class ReportViewController: UIViewController {
  
  @IBOutlet weak var textViewReport: UITextView!
  
  var rootView: ViewController = ViewController()
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    rootView = UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController
    generateReport()
  }
  
  override func viewDidDisappear(animated: Bool) {
    Helper.updateView(rootView)
  }
  
  func generateReport () {
    textViewReport.text = "\(rootView.customers.count) visited your stand today \n"
    
    for customer in rootView.customers {
      let didBuy = customer.didBuy ? "Yes" : "No"
      textViewReport.text = textViewReport.text + "\n" + customer.name + ", bought lemonade: " + didBuy
    }
    
    rootView.inventory.lemonadeRatio -= 0.1
    rootView.sales = 0
    rootView.customers = []
    rootView.inventory.weatherDegrees = rootView.inventory.randomizeWeather()
  }

  
  
}