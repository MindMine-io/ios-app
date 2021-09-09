//
//  Utils.swift
//  MindMine
//
//  Created by Hugo on 09/09/2021.
//

import Foundation

// Extends the Double type to convert to Int
// Simply do doubleObject.int to convert doubleObject
extension Double {
     var int: Int {
         get { Int(self) }
         set { self = Double(newValue) }
     }
 }
