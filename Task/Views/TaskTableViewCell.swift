//
//  TaskTableViewCell.swift
//  Task
//
//  Created by James Hager on 3/23/22.
//

import UIKit

protocol TaskTableViewCellDelegate {
    func completedButtonTapped(in cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completedButton: UIButton!
    
    // MARK: - Properties
    
    var delegate: TaskTableViewCellDelegate?
    
    // MARK: - View Methods
    
    func updateViews(for task: Task) {
        taskNameLabel.text = task.name
        
        completedButton.clipsToBounds = true
        completedButton.contentMode = .scaleAspectFill
        
        if task.isComplete {
            completedButton.setImage(UIImage(named: "complete"), for: .normal)
        } else {
            completedButton.setImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
    // MARK: - Actions

    @IBAction func completedButtonTapped(_ sender: Any) {
        delegate?.completedButtonTapped(in: self)
    }
}
