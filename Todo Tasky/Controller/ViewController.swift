//
//  ViewController.swift
//  Todo Tasky
//
//  Created by sanamsuri on 06/10/18.
//  Copyright © 2018 sanamsuri. All rights reserved.
//

import UIKit
import CoreData




// Global Variables and Constants
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class ViewController: UIViewController {
    
    
    // Outlets
    @IBOutlet weak var tv: UITableView!
    
    
    // Varables
    var taskArray = [Task]()
    
    
    // Constants
    let cellid = "CellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        callDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       fetchyData()
        tv.reloadData()
    }
    
    func fetchyData(){
        fetchData { (done) in
            if done {
                if taskArray.count > 0 {
                    tv.isHidden = false
                } else {
                    tv.isHidden = true
                }
            }
        }
    }
    
    func callDelegates(){
        tv.delegate = self
        tv.dataSource = self
        tv.isHidden = true
    }
    
    


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! TableViewCell
        let task = taskArray[indexPath.row]
        cell.taskLbl.text = task.taskDescription
        if task.taskStatus == true {
            cell.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            cell.taskLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteData(indexPath: indexPath)
            self.fetchyData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let taskStatusAction = UITableViewRowAction(style: .normal, title: "Completed") { (action, indexPath) in
            self.updateTaskStatus(indexPath: indexPath)
            self.fetchyData()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        taskStatusAction.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        return [deleteAction, taskStatusAction]
    }
    
    
    
}

extension ViewController {
    func fetchData(completion: (_ complete: Bool) -> ()) {
         guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            taskArray = try  managedContext.fetch(request) as! [Task]
            print("Data fetched, no issues")
            completion(true)
        } catch {
            print("Unable to fetch data: ", error.localizedDescription)
            completion(false)
        }
        
    }
    
    func deleteData(indexPath: IndexPath) {
         guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(taskArray[indexPath.row])
        do {
            try managedContext.save()
            print("Data Deleted")
            
        } catch {
            print("Failed to delete data: ", error.localizedDescription)
            
        }
    }
    
    func updateTaskStatus(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let task = taskArray[indexPath.row]
        if task.taskStatus == true {
            task.taskStatus = false
        } else {
            task.taskStatus = true
        }
        do {
            try managedContext.save()
            print("Data updated")
            
        } catch {
            print("Failed to update data: ", error.localizedDescription)
            
        }
        
    }
    
    
    
    
}
