//
//  OnboardingView.swift
//  MindMine
//
//  Created by Hugo on 12/07/2021.
//

import SwiftUI

struct OnboardingView: View {
    
    var onboardingCards: [OnboardingCard] = onboardingCardsData
    
    var body: some View {
        TabView(content:  {
            ForEach(onboardingCards) { item in
                OnboardingCardView(onboardingCard: item)
            }
        })
        .tabViewStyle(PageTabViewStyle()) // Switch to page scroll instead of tabs
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always)) // Navigation dots
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
