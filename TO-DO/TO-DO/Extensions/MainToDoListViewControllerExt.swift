//
//  MainToDoListViewController.swift
//  TO-DO
//
//  Created by Olaf Bergmann on 18/08/2019.
//  Copyright © 2019 Olaf Bergmann. All rights reserved.
//

import UIKit

extension MainToDoListViewController {
    
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
