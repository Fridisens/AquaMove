//
//  SplashScreenView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    
    var body: some View {
        VStack {
            Spacer()
            if isActive {
                TabBarView()
            } else {
                Image("First image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                self.isActive = true
                            }
                            
                        }
                    }
                    
            }
            Spacer()
        }
        .transition(.scale)
    }
}

#Preview {
    SplashScreenView()
}
