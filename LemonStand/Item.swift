//
//  Items.swift
//  LemonStand
//
//  Created by Mattias Lundblad on 2015-06-13.
//  Copyright (c) 2015 Mattias Lundblad. All rights reserved.
//

import Foundation

protocol Item {
  var name: String { get set }
  var price: Int { get set }
  static var toPurchase: Int { get set }
  static var toMix: Int { get set }
  static var isDragging: Bool { get set }
  init ()
}

struct Lemon: Item {
  var name = "Lemon"
  var price = 2
  static var toPurchase = 0
  static var toMix = 0
  static var isDragging = false
}

struct IceCube: Item {
  var name = "Ice Cube"
  var price = 1
  static var toPurchase = 0
  static var toMix = 0
  static var isDragging = false
}