//
//  SleepModel.swift
//  MindMine
//
//  Created by SimonDahan on 12/10/2021.
//

import RealmSwift
import Combine
import SwiftUI

// Realm object model
class SleepItem: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId // Primary key id
    @Persisted var name = "New Sleep Item" // Hard-coded name
    @Persisted var value = Int.random(in: 1..<12) // Random number
    // Uncomment next line if items need reference to the group they belong to
    // @Persisted(originProperty: "items") var group: LinkingObjects<ActivityGroup>
}

// Defines "group of items" model. Useful for computed properties on list of objects
// We expect to define only one of these groups in the database, as a list of mood items
class SleepGroup: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = "Sleep"
    @Persisted var items = RealmSwift.List<SleepItem>() // Defines Realm list
    
    // Computed property: average of "int" attribute of items
    var mean: Double {
        var meanValue = 0
        for item in items {
            meanValue = meanValue + item.value
        }
        return Double(meanValue)/Double(items.count)
    }
}

