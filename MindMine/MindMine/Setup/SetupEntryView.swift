//
//  SetupView.swift
//  MindMine
//
//  Created by Hugo on 20/07/2021.
//

import SwiftUI

// Entrypoint view for Setup screens,
// created to make onboarding views non dependent of setup flow modifications
struct SetupEntryView: View {
    
    var body: some View {
        // First view of the Setup flow
        SetupNameView()
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupEntryView()
    }
}
