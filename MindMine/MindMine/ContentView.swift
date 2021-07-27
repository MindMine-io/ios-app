//
//  ContentView.swift
//  MindMine
//
//  Created by Hugo on 12/07/2021.
//

import SwiftUI

struct ContentView: View {
    
    // Accessing tag in UserDefaults on whether onboarding has already been done
    @AppStorage("onboardingDone") var onboardingDone: Bool = false
    
    var body: some View {
        // Show main content or onboarding
        if onboardingDone {
            MainView()
        }
        else {
            OnboardingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
