//
//  OnboardingCardView.swift
//  MindMine
//
//  Created by Hugo on 14/07/2021.
//

import SwiftUI

struct OnboardingCardView: View {
    
    // Onboarding data
    var onboardingCard: OnboardingCard
    // Whether to show button or not
    var showButton: Bool
    // Getting onboarding state tag from UserDefault to update it if button clicked
    @AppStorage("onboardingDone") var onboardingDone: Bool = false
    
    var body: some View {
        VStack {
            Text(onboardingCard.headline)
            Text(onboardingCard.content)
            // Change onboarding state in UserDefaults on button click
            // Triggers main view (see ContentView) and prevent showing onboarding on relaunch
            Button("Getting started") {
                onboardingDone = true
            }
            .disabled(!showButton) // Only show based on 'showButton' toggle
        }
    }
}

struct OnboardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(onboardingCard: onboardingCardsData[1], showButton: false)
    }
}
