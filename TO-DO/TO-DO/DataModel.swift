//
//  DataModel.swift
//  TO-DO
//
//  Created by Olaf Bergmann on 06/08/2019.
//  Copyright © 2019 Olaf Bergmann. All rights reserved.
//

import Foundation


class DataModel {
    
    struct Task {
        var taskName: String
        var taskData: NSData
        
    }
    
    var Tasks: [Task] = []
    
    func addTask(taskName: String, taskData: NSData) {
        let task = Task(taskName: taskName, taskData: taskData)
        Tasks.append(task)
    }
    
    func deleteTask(numberOfRow: Int) {
        Tasks.remove(at: numberOfRow)
    }
    
    
}




