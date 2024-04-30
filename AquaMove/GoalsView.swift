//
//  GoalsView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import SwiftUI

struct GoalsView: View {
    @ObservedObject var viewModel: GoalsViewModel
    @State private var selectedDate = Date()  // Håller reda på det valda datumet

    var body: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "Välj ett datum",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(GraphicalDatePickerStyle()) // Visar en kalender där användare kan välja datum
                .padding()

                Button("Visa vanor för dagen") {
                    // Här kan du lägga till logik för att ladda data om vanorna för valt datum
                    viewModel.loadGoals(for: selectedDate)
                }
                .padding()

                if let goals = viewModel.goalsForSelectedDay {
                    List(goals, id: \.id) { goal in
                        GoalRow(goal: goal)
                    }
                } else {
                    Text("Inga vanor planerade för denna dag.")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Dina vanor")
        }
    }
}
