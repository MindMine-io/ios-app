//
//  ActivityModel.swift
//  MindMine
//
//  Created by Hugo on 30/07/2021.
//

import RealmSwift
import Combine
import SwiftUI

// Realm object model
class ActivityItem: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId // Primary key id
    @Persisted var name = "New Item" // Hard-coded name
    @Persisted var int = Int.random(in: 1..<100) // Random number
    // Uncomment next line if items need reference to the group they belong to
    // @Persisted(originProperty: "items") var group: LinkingObjects<ActivityGroup>
}

// Defines "group of items" model. Useful for computed properties on list of objects
// We expect to define only one of these groups in the database, as a list of activity items
class ActivityGroup: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = "Activity"
    @Persisted var items = RealmSwift.List<ActivityItem>() // Defines Realm list
    
    // Computed property: average of "int" attribute of items
    var mean: Double {
        var meanValue = 0
        for item in items {
            meanValue = meanValue + item.int
        }
        return Double(meanValue)/Double(items.count)
    }
}
