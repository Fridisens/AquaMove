//
//  ContentView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-24.
//

import SwiftUI
import Firebase


struct ContentView: View {
    let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            Image("First image")
                .resizable()
                .imageScale(.small)
                .foregroundStyle(.tint)
        }.onAppear() {
            //test info till Firebase
            db.collection("habit").addDocument(data: ["Habit:" : "Yoga"])
        }
         
        .padding()
    }
}

#Preview {
    ContentView()
}
