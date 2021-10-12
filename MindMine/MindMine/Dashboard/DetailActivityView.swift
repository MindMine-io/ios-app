//
//  DetailActivityView.swift
//  MindMine
//
//  Created by Hugo on 02/08/2021.
//

import SwiftUI
import RealmSwift

struct DetailActivityView: View {
    
    // Equivalent of @Binding -> referenced in parent view,
    // trigger view update on modification
    @ObservedRealmObject var activityItems: ActivityGroup
    // should be private!
    var healthStore: HealthDataStore?
    
    //init() {
    //    healthStore = HealthDataStore()
    //}

    
    // Activity data detail view
    var body: some View {
        // As fisrt version, activity items list and "add" button
        VStack {
            List{
                ForEach(activityItems.items) { item in
                    Text(String(item.value))
                }
            }
            Spacer()
            Button("Add item") {
                // Create new item and add to list -> trigger Realm write under the hood
                $activityItems.items.append(ActivityItem())
            }.padding() 
            
            List{
            }
            Spacer()
            Button("Add HealthKit data") {
                // Create new item and add to list -> trigger Realm write under the hood
                //if let healthStore = healthStore
                healthStore?.requestAuthorisation(completion: { (success) in
                })
                
                
                
            }.padding()
        }
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailActivityView(activityItems: ActivityGroup())
    }
}
