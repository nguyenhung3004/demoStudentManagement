//
//  StudentsVC.swift
//  demoStudentsManagement
//
//  Created by Hung Nguyen on 4/15/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class StudentsVC: UITableViewController {

    var selectedStudentIndex: Int?
    @IBOutlet weak var nameTextField1: UITextField!
    
    @IBOutlet weak var nameTextField2: UITextField!
    
    @IBOutlet weak var chosenImageView: ImageView!{
        didSet {
            chosenImageView.contentMode = .scaleAspectFill
            chosenImageView.borderColor = .gray
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }

    }
    
    var chosenImage: UIImage?{
        didSet {
            chosenImageView.image = chosenImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index = selectedStudentIndex{
            let student = DataServices.shared.students[index]
            nameTextField1.text = student.name
            nameTextField2.text = student.phoneNum
            chosenImage = student.image
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func saveButton() {
        if let newStudent = StudentModal(name: nameTextField1.text ?? "", phoneNum: nameTextField2.text ?? "", image: chosenImage){
            
            cancelButton(UIBarButtonItem())
            if selectedStudentIndex == nil {
                DataServices.shared.appendStudent(student: newStudent)
            }
            else {
                DataServices.shared.replace(student: newStudent, at: selectedStudentIndex!)
            }
        }
        else {
            showWrongDataAlert()
        }
    }
    
    func showWrongDataAlert(){
        let title = "Wrong intput"
        let message = "Please insert name's characters > 0, and phone number's characters > 9"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    
    }
    @IBAction func addImage(_ sender: Any?) {
        let title = "Action Sheet"
        let message = "What would you like to do?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Pick Photo", style: .default, handler: pickPhoto))
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default,handler: takePhoto))
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: {(action) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func takePhoto(action : UIAlertAction) -> Void{
        unowned let weakself = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = weakself as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            weakself.present(imagePicker, animated: true, completion: nil)
        }
        else {}
    }
    func pickPhoto(action : UIAlertAction) -> Void{
        
        unowned let weakself = self
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = weakself as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        weakself.present(imagePicker, animated: true, completion: nil)
       
    }
}
extension StudentsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}
