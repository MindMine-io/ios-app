//
//  DetailMoodView.swift
//  MindMine
//
//  Created by Hugo on 07/09/2021.
//

import SwiftUI
import RealmSwift

struct DetailMoodView: View {
    
    // Equivalent of @Binding -> referenced in parent view,
    // trigger view update on modification
    @ObservedRealmObject var moodItems: MoodGroup
    
    // Boolean to dismiss/present the modal view (see Button behavior below)
    @State private var isShowingSheet = false
    
    // Mood data detail view
    var body: some View {
        // As first version, mood items list and "add" button
        VStack {
            List{
                ForEach(moodItems.items) { item in
                    Text(String(item.value))
                }
            }
            Spacer()
            Button("Add item") {
                // Updating state variable to dismiss/present InputMoodView()
                isShowingSheet.toggle()
            }.padding()
            .sheet(isPresented: $isShowingSheet) { // Modal view presentation to input mood entry
                InputMoodView(moodItems: moodItems, isPresented: $isShowingSheet)
            }
        }
    }
}

struct DetailMoodView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMoodView(moodItems: MoodGroup())
    }
}
