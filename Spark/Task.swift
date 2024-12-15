//
//  Task.swift
//  ch4
//
//  Created by ohoud on 10/06/1446 AH.
//

import SwiftUI
import Foundation

struct Task: Identifiable {
    var id = UUID() // Unique identifier
    var name: String
    var duration: String // e.g., "15 min"
    var priority: String // e.g., "⚡️ High"
    var isChecked: Bool // To track completion status

    // Convert duration string (e.g., "15 min") to TimeInterval in seconds
    func toSeconds() -> TimeInterval? {
        // Extract the numeric part and convert it to an integer
        if let minutesString = duration.split(separator: " ").first,
           let minutes = Int(minutesString) {
            return TimeInterval(minutes * 60) // Convert minutes to seconds
        }
        return nil // Return nil if conversion fails
    }
    
    static let sampleTasks: [Task] = [
            Task(name: "Morning Exercise", duration: "30 min", priority: "⚡️ High", isChecked: false),
            Task(name: "Grocery Shopping", duration: "45 min", priority: "⏳ Medium", isChecked: true),
            Task(name: "Code Review", duration: "60 min", priority: "⚡️ High", isChecked: false),
            Task(name: "Read Book", duration: "20 min", priority: "⏳ Medium", isChecked: false),
            Task(name: "Meditation", duration: "15 min", priority: "🌿 Low", isChecked: true)
        ]
}

    

