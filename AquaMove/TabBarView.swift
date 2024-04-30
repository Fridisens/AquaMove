//
//  TabBarView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import SwiftUI
import Firebase

struct TabBarView: View {
    let db = Firestore.firestore()
    
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
