//
//  BaseProgressView.swift
//  MindMine
//
//  Created by Hugo on 26/07/2021.
//

import SwiftUI

// Shell view containing progress bar
// To be call as BaseProgressView(progressValue) { -custom content views- }
struct BaseProgressView<Content: View>: View {
    
    // Progress bar value between 0 and 1
    let progressValue: Float
    let content: Content
    // @ViewBuilder: allows for views closure calls
    init(progressValue: Float = 0, @ViewBuilder content: () -> Content) {
        self.progressValue = progressValue
        self.content = content()
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progressValue) // Built-in progress bar view
            Spacer() // Pushes progress bar to top and content to bottom
            content
            Spacer() // Pushes content to top -> becomes centred
        }.padding()
    }
}

struct BaseProgressView_Previews: PreviewProvider {
    static var previews: some View {
        BaseProgressView() {}
    }
}
