//
//  TaskListTableViewController.swift
//  Task
//
//  Created by James Hager on 3/23/22.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TaskController.shared.loadFromPersistentStore()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        cell.updateViews(for: TaskController.shared.tasks[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TaskController.shared.deleteTask(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailWithTask" {
            guard let destination = segue.destination as? TaskDetailViewController,
                  let indexPath = tableView.indexPathForSelectedRow
            else { return }
            destination.task = TaskController.shared.tasks[indexPath.row]
        }
    }
}

// MARK: - TaskTableViewCellDelegate

extension TaskListTableViewController: TaskTableViewCellDelegate{
    
    func completedButtonTapped(in cell: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        TaskController.shared.toggleIsCompleteForTask(atIndex: indexPath.row)
        cell.updateViews(for: TaskController.shared.tasks[indexPath.row])
    }
}
