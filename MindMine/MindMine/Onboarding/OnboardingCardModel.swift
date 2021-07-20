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

// Setting onboarding data here, could go in separate file,
// plist or retrieved from server API if need be
let onboardingCardsData: [OnboardingCard] = [
    OnboardingCard(headline: "First onboarding", content: "Card content"),
    OnboardingCard(headline: "Second onboarding", content: "Card content"),
    OnboardingCard(headline: "Third onboarding", content: "Card content")
]
