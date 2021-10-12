//
//  DetailSleepView.swift
//  MindMine
//
//  Created by SimonDahan on 12/10/2021.
//

import SwiftUI
import RealmSwift

struct DetailSleepView: View {
    
    // Equivalent of @Binding -> referenced in parent view,
    // trigger view update on modification
    @ObservedRealmObject var sleepItems: SleepGroup
    
    // Activity data detail view
    var body: some View {
        // As fisrt version, activity items list and "add" button
        VStack {
            List{
                ForEach(sleepItems.items) { item in
                    Text(String(item.value))
                }
            }
            Spacer()
            Button("Add new sleep item") {
                // Create new item and add to list -> trigger Realm write under the hood
                $sleepItems.items.append(SleepItem())
            }.padding()
        }
    }
}


struct DetailSleepView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSleepView(sleepItems: SleepGroup())
    }
}
