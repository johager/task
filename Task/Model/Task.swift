//
//  Task.swift
//  Task
//
//  Created by James Hager on 3/23/22.
//

import Foundation

class Task: Codable {
    var name: String
    var notes: String?
    var dueDate: Date?
    var isComplete: Bool
    
    init(name: String, notes: String?, dueDate: Date?, isComplete: Bool = false) {
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
}
