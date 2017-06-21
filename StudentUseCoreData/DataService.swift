//
//  DataService.swift
//  StudentUseCoreData
//
//  Created by Hung Nguyen on 6/3/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class DataService {
    static let shared: DataService = DataService()
    private let context = Database.viewContext()
    
    private var _facultis: [Faculty]?
    var facultis : [Faculty]!
    func updateFaculty(){
        
        _facultis = try! context.fetch(Faculty.fetchRequest())
        
        facultis = _facultis!
    }
    
    func addStudent(name: String, phone: Int16, avatar: UIImage, facultyName: String){
        // Add data to Database
        let tempFacultis = facultis.filter { (faculty) -> Bool in
            if faculty.name == facultyName {
                return true
            }
            return false
        }
        // Ten khoa bi trung
        if let firstFaculty = tempFacultis.first {
            let student = Student(context: Database.viewContext())
            student.name = name
            student.phoneNum = phone
            student.avatar = avatar
            firstFaculty.addToStudents(student)
//            save()
            return
        }
            // Khong trung ten khoa
        else {
            let faculty = Faculty(context: context)
            let student = Student(context: context)
            student.name = name
            student.phoneNum = phone
            student.avatar = avatar
            faculty.name = facultyName
            faculty.addToStudents(student)
            
            // them data vao mang phu
            faculty.students?.adding(student)
            facultis.append(faculty)
            
//            save()
        }
    }

    
    func studentsFromFaculty(index: Int) -> [Student]{
        let students = Array(facultis[index].students!) as! [Student]
        
        return students
    }
    
    func deleteStudent(index: IndexPath){

        var students = studentsFromFaculty(index: index.section)
        let student = students[index.row]
        students.remove(at: index.row)
        
        context.delete(student)
        facultis[index.section].removeFromStudents(student)
        
        if studentsFromFaculty(index: index.section).count == 0 {
//            let faculty = facultis[index.section]
           
            context.delete(facultis[index.section])
            facultis.remove(at: index.section)
        }
//        save()
    }
    
    func updateStudent(index: IndexPath,name: String, phone: Int16, avatar: UIImage, facultyName: String){
        deleteStudent(index: index)
        addStudent(name: name, phone: phone, avatar: avatar, facultyName: facultyName)
    }
    
    func save(){
        Database.saveContext()
    }
}
