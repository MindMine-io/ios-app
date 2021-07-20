//
//  SetupView.swift
//  MindMine
//
//  Created by Hugo on 20/07/2021.
//

import SwiftUI

struct SetupView: View {
    
    // Getting onboarding state tag from UserDefault to update it if button clicked
    @AppStorage("onboardingDone") var onboardingDone: Bool = false
    
    var body: some View {
        VStack {
            Text("Setup view")
            // Change onboarding state in UserDefaults on button click
            // Triggers main view (see ContentView) and prevent showing onboarding & setup on relaunch
            Button("Getting started") {
                onboardingDone = true
            }
        }
        
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
