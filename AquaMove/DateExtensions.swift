//
//  DateExtensions.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-29.
//

import Foundation

extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"  // Ex: Mon, Aug 29
        return formatter.string(from: self)
    }
}
