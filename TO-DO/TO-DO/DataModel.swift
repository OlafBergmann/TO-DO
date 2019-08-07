//
//  DataModel.swift
//  TO-DO
//
//  Created by Olaf Bergmann on 06/08/2019.
//  Copyright © 2019 Olaf Bergmann. All rights reserved.
//

import Foundation


class DataModel {
    
    struct Task: Codable {
        var taskName: String
        var taskDate: String
        
    }
    
    var Tasks: [Task] = []
    
    func addTask(taskName: String, taskDate: String) {
        let task = Task(taskName: taskName, taskDate: taskDate)
        Tasks.append(task)
    }
    
    func deleteTask(numberOfRow: Int) {
        Tasks.remove(at: numberOfRow)
    }
    
    func changeTaskNameAndDate(newTaskName: String,newDate: String, numberOfRow: Int) {
        Tasks[numberOfRow].taskName = newTaskName
        Tasks[numberOfRow].taskDate = newDate
    }
    
    
}




