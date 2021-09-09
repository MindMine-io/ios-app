//
//  MoodModel.swift
//  MindMine
//
//  Created by Hugo on 07/09/2021.
//

import RealmSwift
import Combine
import SwiftUI

// Realm object model
class MoodItem: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId // Primary key id
    @Persisted var name = "New Item" // Hard-coded name
    @Persisted var value: Int // User-set number
    // Uncomment next line if items need reference to the group they belong to
    // @Persisted(originProperty: "items") var group: LinkingObjects<MoodGroup>
}

// Defines "group of items" model. Useful for computed properties on list of objects
// We expect to define only one of these groups in the database, as a list of mood items
class MoodGroup: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = "Mood"
    @Persisted var items = RealmSwift.List<MoodItem>() // Defines Realm list
    
    // Computed property: average of "int" attribute of items
    var mean: Double {
        var meanValue = 0
        for item in items {
            meanValue = meanValue + item.value
        }
        return Double(meanValue)/Double(items.count)
    }
}
