//
//  OnboardingCardView.swift
//  MindMine
//
//  Created by Hugo on 14/07/2021.
//

import SwiftUI

struct OnboardingCardView: View {
    
    var onboardingCard: OnboardingCard
    
    var body: some View {
        VStack {
            Text(onboardingCard.headline)
            Text(onboardingCard.content)
        }
    }
}

struct OnboardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(onboardingCard: onboardingCardsData[1])
    }
}
