//
//  Settings.swift
//  gheb4750_A05
//
//  Created by Delina Ghebrekristos on 2020-03-22.
//  Copyright © 2020 Delina Ghebrekristos. All rights reserved.
//

import SpriteKit


struct PhysicsCategories{
    static let none : UInt32 = 0
    static let log  : UInt32 = UInt32.max
    static let frog: UInt32 =  0b001    //1
    static let ycar1: UInt32 = 0b010     //2
    static let ycar2: UInt32 = 0b100   //3
    static let rcar1: UInt32 = 0b101   //4
    static let rcar2: UInt32 = 0b110    //5
}
