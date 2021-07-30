//
//  MainView.swift
//  MindMine
//
//  Created by Hugo on 27/07/2021.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView{
            DashboardView().tabItem {
                Image(systemName: "house")
                Text("Dashboard")
            }
            DataExportView().tabItem {
                Image(systemName: "square.and.arrow.up")
                Text("Export")
            }
            SettingsView().tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
