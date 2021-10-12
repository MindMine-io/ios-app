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
    @ObservedResults(MoodGroup.self) var moodGroups
    @ObservedResults(SleepGroup.self) var sleepGroups
    
    // Before loading view, check if each ___Group exists,
    // otherwise creates them (to present it in the dashboard view)
    init() {
        let realm = try! Realm() // Get database
        if activityGroups.count == 0 {
            try! realm.write { // Write commands
                realm.add(ActivityGroup())
            }
        }
        if moodGroups.count == 0 {
            try! realm.write { // Write commands
                realm.add(MoodGroup())
            }
        }
        if sleepGroups.count == 0 {
            try! realm.write { // Write commands
                realm.add(SleepGroup())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                // Displays navigation link towards list of items (DetailActivityView)
                if let activityItems = activityGroups.first {
                    NavigationLink(destination: DetailActivityView(activityItems: activityItems)) {
                        // Custom view for ActivityGroup card
                        DashboardActivityView(activityItems: activityItems)
                    }
                }
                if let sleepItems = sleepGroups.first {
                    NavigationLink(destination: DetailSleepView(sleepItems: sleepItems)) {
                        // Custom view for ActivityGroup card
                        DashboardSleepView(sleepItems: sleepItems)
                    }
                }
                if let moodItems = moodGroups.first {
                    NavigationLink(destination: DetailMoodView(moodItems: moodItems)) {
                        // Custom view for MoodGroup card
                        DashboardMoodView(moodItems: moodItems)
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
