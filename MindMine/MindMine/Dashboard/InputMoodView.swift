//
//  InputMoodView.swift
//  MindMine
//
//  Created by Hugo on 08/09/2021.
//

import SwiftUI
import RealmSwift

struct InputMoodView: View {
    
    // Binding from parent view:
    // mood items + isPresetend boolean to dismiss/present the present modal view
    @ObservedRealmObject var moodItems: MoodGroup
    @Binding var isPresented: Bool
    
    // Mood value of new item -> binded to slider below
    @State private var mood = 5.0
    // Whether slider value is being edited or not
    @State private var isEditing = false
    
    
    var body: some View {
        
        Text("Mood entry:")
        
        Slider(
            value: $mood, // binding 'mood' var to the slider value
            in: 0...10,
            step: 1,
            // block below binds isEditing as an edition state
            // isEditing can be used to change behavior or styles when the slider is moving
            onEditingChanged: { editing in
                isEditing = editing
            }
        ).padding()
        
        // Displaying current slider value, changing color if slider is being edited
        Text("\(mood.int)").foregroundColor(isEditing ? .red : .blue)
        
        // Confirm item creation
        Button("Add item") {
            // Create new item and add to list -> trigger Realm write under the hood
            let newItem = MoodItem()
            newItem.value = mood.int // 'mood' converted to Int -> see Double extension in Utils.swift
            $moodItems.items.append(newItem)
            // Dismiss the view (binded to view presentation in parent view)
            isPresented = false
        }.padding()
    }
}

struct InputMoodView_Previews: PreviewProvider {
    static var previews: some View {
        InputMoodView(moodItems: MoodGroup(), isPresented: .constant(true))
    }
}
