//
//  ViewController.swift
//  TO-DO
//
//  Created by Olaf Bergmann on 05/08/2019.
//  Copyright © 2019 Olaf Bergmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var taskName: UITextField!
    
    private var datePicker: UIDatePicker?
    //data have to be save in memory
    var sample = ["Peppa", "Peppin", "Behemotka", "agatka"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //datePicker = UIDatePicker()
        //datePicker?.datePickerMode = .date
        
        //taskName.inputView = datePicker

        
        navigationItem.title = "TO-DO"
        //tableView.tableHeaderView?.backgroundColor = .black
        
    }
    @IBAction func addBtnWasPressed(_ sender: Any) {
        guard taskName.text?.count == 0 else {
            sample.insert(taskName.text!, at: sample.count)
            tableView.insertRows(at: [IndexPath(row: sample.count-1, section: 0)], with: .top)
            taskName.text = ""
            
            return
        }
    }
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        let point = (sender as AnyObject).convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else {
            return
        }
        sample.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .right)
    }
    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return sample.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ToDoTableViewCell
        cell?.taskLbl.text = sample[indexPath.row]
        return cell!
    }
    
}

