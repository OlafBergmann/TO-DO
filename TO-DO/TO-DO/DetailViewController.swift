//
//  DetailViewController.swift
//  TO-DO
//
//  Created by Olaf Bergmann on 06/08/2019.
//  Copyright © 2019 Olaf Bergmann. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var taskTitlePlaceholder: UITextField!
    @IBOutlet weak var datePlaceholder: UITextField!
    
    var delegate: TaskNameDelegate?
    var numberOfRow: Int!
    var taskString: String!
    var dateString: String!
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = taskString
        taskTitlePlaceholder.text = taskString
        datePlaceholder.text = dateString
        setupDatePicker()
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.backgroundColor = .white
        datePlaceholder.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(MainToDoListViewController.dateChanged(datePicker:)), for: .valueChanged)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        datePlaceholder.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func changeTaskNameBtnWasPressed(_ sender: Any) {
        
        guard taskTitlePlaceholder.text?.count == 0 || taskTitlePlaceholder.text!.count > 40 || datePlaceholder.text!.isEmpty else {
            view.endEditing(true)
            delegate?.passTaskName(taskName: taskTitlePlaceholder.text!, date: datePlaceholder.text! ,numberOfRow: numberOfRow)
            self.navigationController?.popViewController(animated: true)
            return
        }
        let alert = UIAlertController(title: "To short or too long task name", message: "Task name should be at least 1 and maximum 40 long", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
