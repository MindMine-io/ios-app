//
//  OnboardingCardModel.swift
//  MindMine
//
//  Created by Hugo on 14/07/2021.
//

import Foundation

struct OnboardingCard: Identifiable {
    var id = UUID()
    var headline: String
    var content: String
}

let onboardingCardsData: [OnboardingCard] = [
    OnboardingCard(headline: "First onboarding", content: "Card content"),
    OnboardingCard(headline: "Second onboarding", content: "Card content"),
    OnboardingCard(headline: "Three onboarding", content: "Card content")
]
