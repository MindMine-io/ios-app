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
    
    var body: some View {
        VStack {
            Text(onboardingCard.headline)
            Text(onboardingCard.content)
            // Button to Setup view
            //  -> as a navigation link to be able to go back to onboarding
            NavigationLink(destination: SetupView()) {
                Text("Start setup")
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
