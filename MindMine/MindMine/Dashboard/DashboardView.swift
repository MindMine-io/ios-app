//
//  DashboardView.swift
//  MindMine
//
//  Created by Hugo on 27/07/2021.
//

import SwiftUI
import RealmSwift

// View for data visualisation
struct DashboardView: View {
    
    // @ObservedResults: equivalent of @State -> view gets updated when object changes
    // Get all the ActivityGroup objects present in the database
    @ObservedResults(ActivityGroup.self) var activityGroups
    
    // Before loading view, check if an ActivityGroup exists,
    // otherwise creates one (to present it in the dashboard view)
    init() {
        let realm = try! Realm() // Get database
        if activityGroups.count == 0 {
            try! realm.write { // Write commands
                realm.add(ActivityGroup())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                // Displays navigation link towards list of items (DetailView)
                if let activityItems = activityGroups.first {
                    NavigationLink(destination: DetailActivityView(activityItems: activityItems)) {
                        // Custom view for ActivityGroup card
                        DashboardActivityView(activityItems: activityItems)
                    }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
