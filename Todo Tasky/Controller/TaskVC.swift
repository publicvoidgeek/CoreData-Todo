//
//  TaskVC.swift
//  Todo Tasky
//
//  Created by sanamsuri on 06/10/18.
//  Copyright © 2018 sanamsuri. All rights reserved.
//

import UIKit
import CoreData

class TaskVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var taskTv: UITextView!
    
    
    // Variables
    
    
    // Constants
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveBtnPressed(_ sender: Any) {
        saveTask { (done) in
            if done {
                print("We need to return now")
                navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Try again")
            }
        }
    }
    
    
    func saveTask(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let task = Task(context: managedContext)
        task.taskDescription = taskTv.text
        task.taskStatus = false
        
        do {
            try managedContext.save()
            print("Data Saved")
            completion(true)
        } catch {
            print("Failed to save data: ", error.localizedDescription)
            completion(false)
        }
        
        
        
    }
    
    
}
