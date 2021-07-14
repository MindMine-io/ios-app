//
//  OnboardingView.swift
//  MindMine
//
//  Created by Hugo on 12/07/2021.
//

import SwiftUI

struct OnboardingView: View {
    
    var body: some View {
        TabView(content:  {
                    Text("First onboarding")
                    Text("Second onboarding")
                    Text("Third onboarding")
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
