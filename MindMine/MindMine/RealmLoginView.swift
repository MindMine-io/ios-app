//
//  RealmLoginView.swift
//  MindMine
//
//  Created by Hugo on 05/10/2021.
//

import SwiftUI
import RealmSwift

struct RealmLoginView: View {
    // Hold an error if one occurs so we can display it.
    @State var error: Error?
    
    // Keep track of whether login is in progress.
    @State var isLoggingIn = false
    
    let app: RealmSwift.App? = RealmSwift.App(id: "mindmine_test-qldtk")
    var body: some View {
        VStack {
            if isLoggingIn {
                ProgressView()
            }
            if let error = error {
                Text("Error: \(error.localizedDescription)")
            }
            Button("Log in anonymously") {
                // Button pressed, so log in
                isLoggingIn = true
                let email = "skroob@example.com"
                let password = "12345"
                app!.login(credentials: Credentials.emailPassword(email: email, password: password)) { (result) in
                    // Remember to dispatch back to the main thread in completion handlers
                    // if you want to do anything on the UI.
                    DispatchQueue.main.async {
                        switch result {
                        case .failure(let error):
                            print("Login failed: \(error)")
                        case .success(let user):
                            print("Login as \(user) succeeded!")
                        }
                    }
                }
            }.disabled(isLoggingIn)
        }
    }
}

struct RealmLoginView_Previews: PreviewProvider {
    static var previews: some View {
        RealmLoginView()
    }
}
