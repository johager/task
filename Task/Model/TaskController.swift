//
//  TaskController.swift
//  Task
//
//  Created by James Hager on 3/23/22.
//

import Foundation

class TaskController {
    
    static let shared = TaskController()
    
    // MARK: - Properties
    
    var tasks = [Task]()
    
    private var persistentStoreURL: URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let storeURL = urls[0].appendingPathComponent("Task.json")
        return storeURL
    }
    
    // MARK: - CRUD
    
    func createTask(withName name: String, notes: String?, dueDate: Date?) {
        tasks.append(Task(name: name, notes: notes, dueDate: dueDate))
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        saveToPersistentStore()
    }
    
    func toggleIsCompleteForTask(atIndex index: Int) {
        let task = tasks[index]
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    func deleteTask(atIndex index: Int) {
        tasks.remove(at: index)
        saveToPersistentStore()
    }
    
    // MARK: - Persist
    
    func saveToPersistentStore() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: persistentStoreURL)
        } catch {
            print("saveToPersistentStore error: \(error)")
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let data = try Data(contentsOf: persistentStoreURL)
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print("loadFromPersistentStore error: \(error)")
            print(error.localizedDescription)
        }
    }
}
