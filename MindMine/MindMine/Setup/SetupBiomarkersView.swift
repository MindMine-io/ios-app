//
//  SetupBiomarkersView.swift
//  MindMine
//
//  Created by Hugo on 23/07/2021.
//

import SwiftUI

struct SetupBiomarkersView: View {
    
    var progressValue: Float = 0.5
    
    var body: some View {
        BaseProgressView(progressValue: progressValue) {
            Text("Setup biomarkers view")
            // Link to next setup view
            NavigationLink(destination: SetupPermissionsView()) {
                Text("To permissions")
            }
        }
    }
}

struct SetupBiomarkersView_Previews: PreviewProvider {
    static var previews: some View {
        SetupBiomarkersView()
    }
}
