//
//  DashboardItemView.swift
//  MindMine
//
//  Created by Hugo on 02/08/2021.
//

import SwiftUI
import RealmSwift

struct DashboardActivityView: View {
    
    // Equivalent of @Binding -> referenced in parent view,
    // trigger view update on modification
    @ObservedRealmObject var activityItems: ActivityGroup
    
    // Activity biomarker card view
    var body: some View {
        Text("\(activityItems.name) \(String(activityItems.mean))")
    }
}

struct DashboardItemView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardActivityView(activityItems: ActivityGroup())
    }
}
