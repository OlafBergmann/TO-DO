//
//  ViewController.swift
//  TO-DO
//
//  Created by Olaf Bergmann on 05/08/2019.
//  Copyright © 2019 Olaf Bergmann. All rights reserved.
//

import UIKit
import RevealingSplashView
import AudioToolbox

protocol TaskNameDelegate {
    func passTaskName(taskName: String, date: String, numberOfRow: Int)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TaskNameDelegate {
    
    func passTaskName(taskName: String, date: String, numberOfRow: Int) {
        dataModel.changeTaskNameAndDate(newTaskName: taskName,newDate: date, numberOfRow: numberOfRow)
        let indexPath = IndexPath(row: numberOfRow, section: 0)
        tableView.reloadRows(at: [indexPath] , with: .fade)
        saveInUserDefaults()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var taskName: UITextField!
    
    @IBOutlet weak var date: UITextField!
    
    private var datePicker: UIDatePicker?
    
    let dataModel = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "logo")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: .toDoMiddleBlue)
        
        navigationController?.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = SplashAnimationType.heartBeat
        revealingSplashView.startAnimation()
        
        navigationItem.title = "TO-DO"
        navigationController?.navigationBar.barTintColor = .white
        
        setupDatePicker()
        setupCurrentDay()
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        loadfromUserDefaults()
        
        revealingSplashView.heartAttack = true
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.backgroundColor = .white
        date.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(ViewController.dateChanged(datePicker:)), for: .valueChanged)
    }
    
    func setupCurrentDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let currentDate = Date()
        date.text = dateFormatter.string(from: currentDate)
    }
    
    @IBAction func addBtnWasPressed(_ sender: Any) {
        guard taskName.text?.count == 0 || taskName.text!.count > 40 else {
            dataModel.addTask(taskName: taskName.text!, taskDate: date.text! )
            tableView.insertRows(at: [IndexPath(row: dataModel.Tasks.count-1, section: 0)], with: .top)
            setupCurrentDay()
            taskName.text = ""
            view.endEditing(true)
            
            saveInUserDefaults()
            return
        }
        
        let alert = UIAlertController(title: "To short or too long task name", message: "Task name should be at least 1 and maximum 40 long", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
        self.present(alert, animated: true)

    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        date.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        let point = (sender as AnyObject).convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else {
            return
        }
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        dataModel.deleteTask(numberOfRow: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .right)
        
        saveInUserDefaults()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = Storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailViewController.taskString = dataModel.Tasks[indexPath.row].taskName
        detailViewController.dateString = dataModel.Tasks[indexPath.row].taskDate
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
        cell?.dateLbl.text = dataModel.Tasks[indexPath.row].taskDate
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
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

