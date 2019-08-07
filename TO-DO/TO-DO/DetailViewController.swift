//
//  DetailViewController.swift
//  TO-DO
//
//  Created by Olaf Bergmann on 06/08/2019.
//  Copyright © 2019 Olaf Bergmann. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var delegate: TaskNameDelegate?
    
    @IBOutlet weak var taskTitlePlaceholder: UITextField!
    
    var numberOfRow: Int!
    
    var taskString: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = taskString
        taskTitlePlaceholder.text = taskString
        
    }
    
    @IBAction func changeTaskNameBtnWasPressed(_ sender: Any) {
        
        delegate?.passTaskName(taskName: taskTitlePlaceholder.text!,numberOfRow: numberOfRow)
    }
    
    
    
}
