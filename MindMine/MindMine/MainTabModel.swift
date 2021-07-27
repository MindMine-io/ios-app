//
//  MainTabModel.swift
//  MindMine
//
//  Created by Hugo on 27/07/2021.
//

import Foundation
import SwiftUI

struct MainTab<Content: View>: Identifiable {
    let id = UUID()
    let view: Content
    let image: Image
    let label: String
}

// Setting onboarding data here, could go in separate file,
// plist or retrieved from server API if need be
let mainTabData = [
    MainTab(view: DashboardView(), image: Image(systemName: "house"), label: "Dashboard"),
]
