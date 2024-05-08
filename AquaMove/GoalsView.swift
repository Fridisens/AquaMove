//
//  GoalsView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import SwiftUI

struct GoalsView: View {
    @ObservedObject var viewModelHabit: HabitsViewModel
    @State private var selectedDate = Date()
        
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Välj ett datum",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                
                let calendar = Calendar.current
                let dayNumber = calendar.component(.weekday, from: selectedDate) - 1
                let todayName = dayName(from: dayNumber)

                List {
                    ForEach(viewModelHabit.habits.filter { $0.days.contains(todayName) }, id: \.id) { habit in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(habit.name).foregroundColor(habit.completedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: selectedDate) }) ? .green : .red)
                                Text(habit.description).font(.subheadline)
                                Text(habit.days)
                                if let waterHabit = habit as? WaterIntakeHabit {
                                    Text("Mål: \(waterHabit.goal, specifier: "%.0f") liter")
                                } else if let wellnessHabit = habit as? WellnessHabit {
                                    Text("Träningslängd: \(wellnessHabit.sessionLength, specifier: "%.0f") minuter")
                                }
                                Text("Aktuell streak: \(habit.currentStreak) dagar")
                                Text("Längsta streak: \(habit.longestStreak) dagar")
                            }
                            Spacer()
                            Button(action: {
                                habit.isCompleted.toggle()
                                viewModelHabit.updateHabitCompletion(habit, on: selectedDate)
                            }) {
                                Image(systemName: habit.completedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: selectedDate) }) ? "checkmark.circle.fill" : "circle")
                                    .font(.largeTitle)
                                    .foregroundColor(habit.completedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: selectedDate) }) ? .green : .gray)
                            }
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
