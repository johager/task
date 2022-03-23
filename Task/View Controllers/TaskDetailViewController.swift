//
//  TaskViewController.swift
//  Task
//
//  Created by James Hager on 3/23/22.
//

import UIKit

class TaskDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Properties
    
    var task: Task?
    
    var dueDate: Date?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - View Methods
    
    func updateViews() {
        guard let task = task else { return }
        
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let taskName = taskNameTextField.text else { return }
        
        if let task = task {
            TaskController.shared.update(task: task, name: taskName, notes: taskNotesTextView.text, dueDate: dueDate)
        } else {
            TaskController.shared.createTask(withName: taskName, notes: taskNotesTextView.text, dueDate: dueDate)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: UIDatePicker) {
        dueDate = sender.date
    }
}
