//
//  OnboardingView.swift
//  MindMine
//
//  Created by Hugo on 12/07/2021.
//

import SwiftUI

struct OnboardingView: View {
    
    // To get which page on the onboarding is currently on screen
    // Need @State because binded by TabView to automatically be updated during navigation
    @State var selectedView = 0
    // Get the onboarding views data
    var onboardingCards: [OnboardingCard] = onboardingCardsData
    
    var body: some View {
        
        // Embedding onboarding in NavigationView
        //  -> allows to come back to it from Setup
        NavigationView {

            // TabView, binding 'selectedView' to update it during navigation
            TabView(selection: $selectedView,
                    content: {
                        // Loop through all onboarding pages
                        ForEach(onboardingCards.indices) { index in
                            // Display corresponding view, passing information whether
                            // current index is the last one or not (to trigger button)
                            OnboardingCardView(onboardingCard: onboardingCards[index], showButton: selectedView == onboardingCards.count - 1).tag(index)
                            // Need .tag() when using 'selection' in TabView to correctly link navigation dots
                }
            })
            .tabViewStyle(PageTabViewStyle()) // Switch to page swipe instead of tabs
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always)) // Show navigation dots
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
