//
//  ViewController.swift
//  ContactList
//
//  Created by Alexandr Yanski on 10.10.2018.
//  Copyright © 2018 Lonely Tree Std. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contactPhoto: UIImageView!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var takeName: String?
    var takeAvatar: UIImage?
    var takeMobile: String?
    var takeEmail: String?
    var takeNotes: String?
    
    var indexPath: IndexPath?
    var passDelegate: PassDataDelegate? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactPhoto.layer.cornerRadius = self.contactPhoto.bounds.size.width / 2.0
        self.contactPhoto.clipsToBounds = true
        
        if let image = takeAvatar {
            contactPhoto.image = image
        }
        if let name = takeName {
            nameLabel.text = name
        }
        if let mobile = takeMobile {
            mobileLabel.text = mobile
        }
        if let email = takeEmail {
            emailLabel.text = email
        }
        if let notes = takeNotes {
            notesLabel.text = notes
        }
    }
    
    //MARK: - Edit contact
    @IBAction func editButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddingContactID") as! AddingContact
        
        vc.editName = nameLabel.text
        vc.editAvatar = contactPhoto.image
        vc.editMobile = mobileLabel.text
        vc.editEmail = emailLabel.text
        vc.editNotes = notesLabel.text
        vc.indexPath = indexPath
        vc.delegate = passDelegate
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }



}

