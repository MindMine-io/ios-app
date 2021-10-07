//
//  SyncMainView.swift
//  MindMine
//
//  Created by Hugo on 05/10/2021.
//

import SwiftUI
import RealmSwift

struct SyncMainView: View {
   // @AutoOpen attempts to connect to the server and download remote changes
   // before the realm opens, which might take a moment. However, if there is
   // no network connection, AutoOpen will open a realm on the device.s
   // We can use an empty string as the partitionValue here because we're
   // injecting the user.id as an environment value from the LoginView.
   @AutoOpen(appId: "mindmine_test-qldtk", partitionValue: "321", timeout: 4000) var autoOpen
   var body: some View {
      // Switch on the AsyncOpenState enum to update the view
      // based on AutoOpen progress.
      switch autoOpen {
      // Starting the Realm.asyncOpen process.
      // Show a progress view.
      case .connecting:
         ProgressView()
      // Waiting for a user to be logged in before executing Realm.asyncOpen
      case .waitingForUser:
         ProgressView("Waiting for user to log in...")
        RealmLoginView()
      // The realm has been opened and is ready for use.
      // Show the content view.
      case .open(let realm):
        let _ = print("successful")
        Text("success")
//         ListView()
//            .environment(\.realm, realm)
      // The realm is currently being downloaded from the server.
      // Show a progress view.
      case .progress(let progress):
         ProgressView(progress)
      // Opening the Realm failed.
      // Show an error view.
      case .error(_):
         let _ = print("error")
        EmptyView()
      }
   }
}

struct SyncMainView_Previews: PreviewProvider {
    static var previews: some View {
        SyncMainView()
    }
}
