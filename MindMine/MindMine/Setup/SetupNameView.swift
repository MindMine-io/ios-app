//
//  SetupNameView.swift
//  MindMine
//
//  Created by Hugo on 23/07/2021.
//

import SwiftUI

struct SetupNameView: View {
    
    var progressValue: Float = 0.2
    
    var body: some View {
        BaseProgressView(progressValue: progressValue) {
            Text("Setup name view")
            // Link to next setup view
            NavigationLink(destination: SetupBiomarkersView()) {
                Text("To biomarkers")
            }
        }
    }
}

struct SetupNameView_Previews: PreviewProvider {
    static var previews: some View {
        SetupNameView()
    }
}
