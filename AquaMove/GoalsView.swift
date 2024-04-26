//
//  GoalsView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import SwiftUI

struct GoalsView: View {
    @ObservedObject var viewModel = GoalsViewModel()

    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.dailyGoals) { goal in
                            DayView(goal: goal)
                        }
                    }
                }
            }
        }

        struct DayView: View {
            var goal: DailyGoal

            var body: some View {
                VStack {
                    Text(goal.day)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(goal.goalsCompleted ? Color.green : Color.red)
                        .cornerRadius(10)
                    
                  

                    if goal.goalsCompleted {
                        Image(systemName: "checkmark.circle")
                    } else {
                        Image(systemName: "xmark.circle")
                        
                    }
                    Spacer()
                }
        
                .padding(.horizontal)
            }
        }
