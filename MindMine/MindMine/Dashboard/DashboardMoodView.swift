//
//  DashboardMoodView.swift
//  MindMine
//
//  Created by Hugo on 07/09/2021.
//

import SwiftUI
import RealmSwift

struct DashboardMoodView: View {
    
    // Equivalent of @Binding -> referenced in parent view,
    // trigger view update on modification
    @ObservedRealmObject var moodItems: MoodGroup
    
    // Mood biomarker card view
    var body: some View {
        Text("\(moodItems.name) \(String(moodItems.mean))")
    }
}

struct DashboardMoodView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardMoodView(moodItems: MoodGroup())
    }
}
