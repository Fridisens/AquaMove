//
//  HabitsView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import SwiftUI
import Firebase

struct HabitsView: View {
    @ObservedObject var viewModel = HabitsViewModel()
    @State private var showingAddHabit = false
    
    var habits: [Habit] = []
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.habits, id: \.id) { habit in
                    VStack(alignment: .leading) {
                        Text(habit.name)
                            .font(.headline)
                        Text(habit.description)
                            .font(.subheadline)
                        Text(habit.days)
                        if let waterHabit = habit as? WaterIntakeHabit {
                            Text("Mål: \(waterHabit.goal, specifier: "%.0f") liter")
                        } else if let wellnessHabit = habit as? WellnessHabit {
                            Text("Träningslängd: \(wellnessHabit.sessionLength, specifier: "%.0f") minuter")
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteHabit)
                
            }
            .navigationTitle("Lista på vanor")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddHabit = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView(habits: $viewModel.habits)
            }
        }
    }
}
