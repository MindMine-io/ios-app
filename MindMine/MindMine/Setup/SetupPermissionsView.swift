//
//  SetupPermissionsView.swift
//  MindMine
//
//  Created by Hugo on 23/07/2021.
//

import SwiftUI

struct SetupPermissionsView: View {
    
    // Getting onboarding state tag from UserDefault to update it if button clicked
    @AppStorage("onboardingDone") var onboardingDone: Bool = false
    
    var progressValue: Float = 0.8
    
    var body: some View {
        BaseProgressView(progressValue: progressValue) {
            Text("Setup permissions view")
            // Change onboarding state in UserDefaults on button click
            // Triggers main view (see ContentView) and prevent showing onboarding & setup on relaunch
            Button("Getting started") {
                onboardingDone = true
            }
        }
        
    }
}

struct SetupPermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        SetupPermissionsView()
    }
}
