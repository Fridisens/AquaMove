//
//  SimpleDayView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-30.
//
import SwiftUI

struct SimpleDayView: View {
    
    @State private var days: [DaySelection] = [
        DaySelection(name: "Måndag", isSelected: false),
        DaySelection(name: "Tisdag", isSelected: false),
        DaySelection(name: "Onsdag", isSelected: false),
        DaySelection(name: "Torsdag", isSelected: false),
        DaySelection(name: "Fredag", isSelected: false),
        DaySelection(name: "Lördag", isSelected: false),
        DaySelection(name: "Söndag", isSelected: false)
    ]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            ForEach($days.indices, id: \.self) { index in
                Button(action: {
                    days[index].isSelected.toggle()
                }) {
                    Text(days[index].name)
                        .foregroundColor(days[index].isSelected ? .white : .black)
                        .padding()
                        .background(days[index].isSelected ? Color.green : Color.gray)
                        .cornerRadius(10)
                }
            }
        }
    }
}
