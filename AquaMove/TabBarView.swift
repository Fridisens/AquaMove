//
//  TabBarView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
           
           UITabBar.appearance().barTintColor = UIColor(red: 93/255, green: 197/255, blue: 182/255, alpha: 1)
           // text colour 
           UITabBar.appearance().unselectedItemTintColor = UIColor.black
       }
       
       var body: some View {
           TabView {
               GoalsView()
                   .tabItem {
                       Label("Mina mål", systemImage: "heart")
                   }
               
               HabitsView()
                   .tabItem {
                       Label("Vanor", systemImage: "drop")
                   }
           }
       }
   }

#Preview {
    TabBarView()
}
