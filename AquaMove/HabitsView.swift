//
//  HabitsView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import SwiftUI

struct HabitsView: View {
    @ObservedObject var viewModel = HabitsViewModel()
    @State private var showingAddHabit = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List(viewModel.habits) { habit in
                VStack(alignment: .leading) {
                    Text(habit.name)
                        .font(.headline)
                    Text(habit.description)
                        .font(.subheadline)
                    if let waterHabit = habit as? WaterIntakeHabit {
                        Text("Mål: \(waterHabit.goal) liter")
                    } else if let wellnessHabit = habit as? WellnessHabit {
                        Text("Sessionlängd: \(wellnessHabit.sessionLength) minuter")
                    }
                }
            }
            
            Button(action: {
                showingAddHabit = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 56, height: 56)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding()
            }
        }
        .sheet(isPresented: $showingAddHabit) {
            AddHabitView(habits: $viewModel.habits)
        }
    }
}
