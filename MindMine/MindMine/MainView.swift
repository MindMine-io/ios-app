//
//  MainView.swift
//  MindMine
//
//  Created by Hugo on 27/07/2021.
//

import SwiftUI

struct MainView: View {
    
    let views = mainTabData
    
    var body: some View {
        TabView{
            ForEach(views) { item in
                item.view.tabItem {
                    item.image
                    Text(item.label)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
