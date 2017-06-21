//
//  ViewController.swift
//  StudentUseCoreData
//
//  Created by Hung Nguyen on 6/3/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController {
    
    var selectedStudentIndex: Int?
    @IBOutlet weak var nameStudenttextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!

    @IBOutlet weak var nameFacultyTextField: UITextField!
    
    @IBOutlet weak var avatarImage: ImageView!
    
    var nameStudent: String?
    var phone: String?
    var nameFaculty: String?
    var image: UIImage?
    var segueStatus: String?
    var index: IndexPath?
    
    var facultis: [Faculty] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if segueStatus == "Edit"{
            nameStudenttextField.text = nameStudent
            phoneNumberTextField.text = phone
            nameFacultyTextField.text = nameFaculty
            avatarImage.image = image
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    

    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let name = nameStudenttextField.text ?? ""
        let phone = Int16(phoneNumberTextField.text!) ?? 0
        let avatar = avatarImage.image
        let faculty = nameFacultyTextField.text ?? ""
        if segueStatus == "Add"{
            DataService.shared.addStudent(name: name, phone: phone, avatar: avatar!, facultyName: faculty)
            dismiss(animated: true, completion: nil)
        }
        if segueStatus == "Edit"{
//            DataService.shared.updateFaculty()
//            DataService.shared.deleteStudent(index: index!)

            DataService.shared.updateStudent(index: index!, name: name, phone: phone, avatar: avatar!, facultyName: faculty)
            let _ = navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        let _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: Any?) {
        let title = "Add Image"
        let message = "What would you like to do?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Pick Photo", style: .default, handler: pickPhoto))
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: takePhoto))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    

    func takePhoto(action: UIAlertAction) -> Void{
        unowned let weakself = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = weakself as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            weakself.present(imagePicker, animated: true, completion: nil)
        } else {}
    }
    
    func pickPhoto(action: UIAlertAction) -> Void{
        unowned let weakself = self
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = weakself as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        weakself.present(imagePicker, animated: true, completion: nil)
    }
}

extension DetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        avatarImage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}
