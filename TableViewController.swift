//
//  TableViewController.swift
//  StudentUseCoreData
//
//  Created by Hung Nguyen on 6/2/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.shared.updateFaculty()
        navigationItem.leftBarButtonItem = editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return DataService.shared.facultis.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.shared.studentsFromFaculty(index: section).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let students = DataService.shared.studentsFromFaculty(index: indexPath.section) 
        let student = students[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.nameTextField.text = student.name
        cell.phoneNumTextField.text = String(student.phoneNum)
        cell.avartar.image = student.avatar as! UIImage?
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DataService.shared.facultis[section].name
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataService.shared.deleteStudent(index: indexPath)
            tableView.reloadData()
        } else if editingStyle == .insert {

        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add"{
            guard let rootVC = segue.destination as? UINavigationController else {return}
            guard let detailVC = rootVC.viewControllers.first as? DetailVC else {return}
            detailVC.segueStatus = "Add"
        }
        if segue.identifier == "Edit"{
            guard let detailVC = segue.destination as? DetailVC else {return}
            guard let selected = sender as? TableViewCell else {return}
            guard let indexPath = tableView.indexPath(for: selected) else {return}
            
            detailVC.index = indexPath
            let students = Array(DataService.shared.facultis[indexPath.section].students!) as! [Student]
            let student = students[indexPath.row]
            
            detailVC.nameStudent = student.name!
            detailVC.image = student.avatar as? UIImage
            detailVC.phone = String(student.phoneNum)
            detailVC.nameFaculty = student.faculty?.name
            detailVC.segueStatus = "Edit"
        }
    }
}
