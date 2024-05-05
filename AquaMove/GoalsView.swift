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
    @ObservedObject var viewModelHabit = HabitsViewModel()
    var habits: [Habit] = []

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
                
                let calendar = Calendar.current
                let dayNumber = calendar.component(.weekday, from: selectedDate) - 1  // Få dagnumret, justera för svensk veckodagsordning
                let todayName = dayName(from: dayNumber)

//                Button("Visa vanor för dagen") {
//                    
//                    viewModel.loadGoals(for: selectedDate)
//                    
//                }
//                .padding()

//                if let goals = viewModel.goalsForSelectedDay {
//                    List(goals, id: \.id) { goal in
//                        GoalRow(goal: goal)
//                    }
//                } else {
//                    Text("Inga vanor planerade för denna dag.")
//                        .foregroundColor(.gray)
//                }
                List {
                    ForEach(viewModelHabit.habits.filter { $0.days.contains(todayName) }, id: \.id) { habit in
                        VStack(alignment: .leading) {
                            Text(habit.name).foregroundColor(habit.isCompleted ? .green : .red)
                            Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "xmark.circle")
                                .foregroundColor(habit.isCompleted ? .green : .red)
                                .font(.headline)
                            Text(habit.description)
                                .font(.subheadline)
                            Text(habit.days)
                            Text("\(habit.isCompleted)")
                            if let waterHabit = habit as? WaterIntakeHabit {
                                Text("Mål: \(waterHabit.goal, specifier: "%.0f") liter")
                            } else if let wellnessHabit = habit as? WellnessHabit {
                                Text("Träningslängd: \(wellnessHabit.sessionLength, specifier: "%.0f") minuter")
                            }
                            Toggle("Utförd", isOn: Binding<Bool>(
                                get: {habit.isCompleted },
                                set: { newValue in
                                    habit.isCompleted = newValue
                                    viewModelHabit.updateHabitCompletion(habit)
                                }
                            ))
                        }
                    }
                }
            }
            .navigationTitle("Dina vanor")
        
        }
    }
    func dayName(from dayNumber: Int) -> String {
        let days = ["Söndag", "Måndag", "Tisdag", "Onsdag", "Torsdag", "Fredag", "Lördag"]
        return days[dayNumber]
    }
}
