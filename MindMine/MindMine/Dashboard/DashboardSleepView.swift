//
//  DashboardSleepView.swift
//  MindMine
//
//  Created by SimonDahan on 12/10/2021.
//

import SwiftUI
import RealmSwift

struct DashboardSleepView: View {
    
    // Equivalent of @Binding -> referenced in parent view,
    // trigger view update on modification
    @ObservedRealmObject var sleepItems: SleepGroup
    
    // Activity biomarker card view
    var body: some View {
        Text("\(sleepItems.name) \(String(sleepItems.mean))")
    }
}

struct DashboardSleepItemView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSleepView(sleepItems:
        SleepGroup())
    }
}

