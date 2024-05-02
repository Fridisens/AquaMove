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
    var habits: [Habit] = []
    
    @State private var showingAddHabit = false
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
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
            .navigationTitle("Lista på vanor")
        }
    }
    func loadHabits() {
            db.collection("habit").getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                   let habits = querySnapshot!.documents.compactMap { document in
                        let habit = try? document.data(as: Habit.self)
                        habit?.id = document.documentID  // Tilldela Firestore dokument-ID
                        return habit
                    }
                }
            }
        }
}
