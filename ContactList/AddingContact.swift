//
//  AddingContact.swift
//  ContactList
//
//  Created by Alexandr Yanski on 23.10.2018.
//  Copyright © 2018 Lonely Tree Std. All rights reserved.
//

import UIKit

protocol PassDataDelegate {
    func passData(value: [String: Any], groupName: Int)
}

class AddingContact: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    @IBOutlet weak var imageTake: UIImageView!
    @IBOutlet weak var sectionSegment: UISegmentedControl!
    
    var imagePicker: UIImagePickerController!
    var delegate: PassDataDelegate?
    let tableViewController = TableViewController()
    
    var editName: String?
    var editAvatar: UIImage?
    var editMobile: String?
    var editEmail: String?
    var editNotes: String?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = indexPath {
            switch index.section {
            case 0:
                friends.remove(at: index.row)
            case 1:
                family.remove(at: index.row)
            case 2:
                colleagues.remove(at: index.row)
            case 3:
                other.remove(at: index.row)
            default: print("Error with edit")
            }
            
            if let name = editName {
                self.nameTextField.text = name
            }
            if let avatar = editAvatar {
                self.imageTake.image = avatar
            }
            if let mobile = editMobile {
                self.mobileTextField.text = mobile
            }
            if let email = editEmail {
                self.emailTextField.text = email
            }
            if let notes = editNotes {
                self.notesTextField.text = notes
            }
        }
        
        self.nameTextField.keyboardAppearance = .dark
        self.mobileTextField.keyboardAppearance = .dark
        self.emailTextField.keyboardAppearance = .dark
        self.notesTextField.keyboardAppearance = .dark
        
        let bottomSwipe = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        bottomSwipe.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(bottomSwipe)
    }
    
    
    //MARK: - Add new contact
    @IBAction func addingContactButton(_ sender: Any) {
        if let name = self.nameTextField.text {
            if let mobile = self.mobileTextField.text {
                if let email = self.emailTextField.text {
                    if let notes = self.notesTextField.text {
                        if self.imageTake.image != nil {
                            delegate?.passData(value: ["name": name, "avatar": self.imageTake.image, "mobile": mobile, "email": email, "notes": notes], groupName: sectionSegment.selectedSegmentIndex)
                            if let navController = self.navigationController {
                                navController.popToRootViewController(animated: true)
                            }
                        } else {
                            delegate?.passData(value: ["name": name, "avatar": UIImage(named: "AppIcon"), "mobile": mobile, "email": email, "notes": notes], groupName: sectionSegment.selectedSegmentIndex)
                            if let navController = self.navigationController {
                                navController.popToRootViewController(animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Selector hiding keyboard
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

    //MARK: - Load Image
    func takeFhotoLibrary() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func takeFhotoCamera() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        let choice = UIAlertController(title: "Please make a selection", message: "Camera or Library?", preferredStyle: .actionSheet)
        choice.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            self.takeFhotoCamera()
        }))
        choice.addAction(UIAlertAction(title: "Library", style: .default, handler: { (_) in
            self.takeFhotoLibrary()
        }))
        choice.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(choice, animated: true)
    }
    
    @IBAction func save(_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(imageTake.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageTake.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }

}
