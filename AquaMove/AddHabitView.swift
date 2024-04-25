//
//  AddHabitView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.presentationMode) var presentationMode
        @Binding var habits: [Habit]

    @State private var selectedCategory = "Vatten"
       @State private var name: String = ""
       @State private var description: String = ""
       @State private var goal: Double = 0
    
    
    var body: some View {
    NavigationView {
                Form {
                    Section(header: Text("Kategori")) {
                        Picker("Välj en kategori", selection: $selectedCategory) {
                            Text("Vatten").tag("Vatten")
                            Text("Träning").tag("Träning")
                        }.pickerStyle(SegmentedPickerStyle())
                    }

                    Section(header: Text("Detaljer")) {
                        TextField("Namn på vanan", text: $name)
                        TextField("Beskrivning", text: $description)
                        if selectedCategory == "Vatten" {
                            TextField("Målvärde (liter)", value: $goal, formatter: NumberFormatter())
                        } else {
                            TextField("Målvärde (minuter)", value: $goal, formatter: NumberFormatter())
                        }
                    }

                    Button("Lägg till vana") {
                        addHabit()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .navigationTitle("Ny Vana")
                .navigationBarItems(trailing: Button("Stäng") {
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }

        func addHabit() {
            let newHabit: Habit
            if selectedCategory == "Vatten" {
                newHabit = WaterIntakeHabit(name: name, description: description, goal: goal)
            } else {
                newHabit = WellnessHabit(name: name, description: description, sessionLength: goal)
            }
            habits.append(newHabit)
        }
    }
