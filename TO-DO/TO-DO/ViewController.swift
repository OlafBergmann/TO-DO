//
//  ViewController.swift
//  TO-DO
//
//  Created by Olaf Bergmann on 05/08/2019.
//  Copyright © 2019 Olaf Bergmann. All rights reserved.
//

import UIKit

protocol TaskNameDelegate {
    func passTaskName(taskName: String, numberOfRow: Int)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TaskNameDelegate {
    
    func passTaskName(taskName: String, numberOfRow: Int) {
        dataModel.changeTaskName(newTaskName: taskName, numberOfRow: numberOfRow)
        let indexPath = IndexPath(row: numberOfRow, section: 0)
        tableView.reloadRows(at: [indexPath] , with: .fade)
        saveInUserDefaults()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var taskName: UITextField!
    
    //private var datePicker: UIDatePicker?
    
    let dataModel = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //datePicker = UIDatePicker()
        //datePicker?.datePickerMode = .date
        //taskName.inputView = datePicker
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = "TO-DO"
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        //tableView.tableHeaderView?.backgroundColor = .black
        loadfromUserDefaults()
    }
    
    @objc func dismissKeyboard() {
    view.endEditing(true)
    
    }
    
    @IBAction func addBtnWasPressed(_ sender: Any) {
        guard taskName.text?.count == 0 || taskName.text!.count > 62 else {
            dataModel.addTask(taskName: taskName.text!, taskData: "06.08.2019")
            tableView.insertRows(at: [IndexPath(row: dataModel.Tasks.count-1, section: 0)], with: .top)
            
            taskName.text = ""
            view.endEditing(true)
            
            saveInUserDefaults()
            return
        }
        
        let alert = UIAlertController(title: "To short or too long task name", message: "Task name should be at least 1 and maximum 62 long", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
        self.present(alert, animated: true)

    }
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        let point = (sender as AnyObject).convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else {
            return
        }
        dataModel.deleteTask(numberOfRow: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .right)
        
        saveInUserDefaults()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailViewController = Storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailViewController.taskString = dataModel.Tasks[indexPath.row].taskName
        
        detailViewController.numberOfRow = indexPath.row
        
        detailViewController.delegate = self
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataModel.Tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ToDoTableViewCell
        cell?.taskLbl.text = dataModel.Tasks[indexPath.row].taskName
        
        cell?.taskLbl.numberOfLines = 0
        cell?.taskLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        let selectedView = UIView()
        selectedView.backgroundColor = .toDoFirstBlue
        cell?.selectedBackgroundView = selectedView
        return cell!
    }
    
    }

extension ViewController {
    
    func saveInUserDefaults() { //save in userDefaults // Saving those kind of data into the UserDefault is not recommended
        let array : [DataModel.Task] = dataModel.Tasks// whatever
        if let data = try? PropertyListEncoder().encode(array) {
            UserDefaults.standard.set(data, forKey: "SavedItemArray")
            
        }
    }
    
    func loadfromUserDefaults() { //load data from userDefaults
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "SavedItemArray") {
            let array = try! PropertyListDecoder().decode([DataModel.Task].self, from: data)
            dataModel.Tasks = array
        }

    }
}

extension UIViewController {
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

