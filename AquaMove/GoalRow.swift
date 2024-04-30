//
//  GoalRow.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-30.
//

import Foundation
import SwiftUI

struct GoalRow: View {
    var goal: DailyGoal

    var body: some View {
        HStack {
            Text(goal.day)
            Spacer()
            Image(systemName: goal.goalsCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(goal.goalsCompleted ? .green : .red)
        }
        .padding(.vertical, 4)
    }
}
