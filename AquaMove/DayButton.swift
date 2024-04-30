//
//  DayButton.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-29.
//

import SwiftUI
import Foundation

struct DayButton: View {
    @Binding var day: DaySelection
    
    var body: some View {
        Button(action: {
            day.isSelected.toggle()
        }) {
            Text(day.name)
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(day.isSelected ? Color.green : Color.gray)
                .cornerRadius(10)
        }
    }
}
