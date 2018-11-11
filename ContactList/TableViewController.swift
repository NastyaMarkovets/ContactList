//
//  TableViewController.swift
//  ContactList
//
//  Created by Alexandr Yanski on 10.10.2018.
//  Copyright © 2018 Lonely Tree Std. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, PassDataDelegate {
    
    let contactSections = ["Friends", "Family", "Colleagues", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ContactCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "contactCell")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonAction))
        
    }
    
    // MARK: - Reload data Table View
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddingContact {
            vc.delegate = self
        }
    }
    
    @objc func deleteButtonAction() {
        self.tableView.setEditing(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
    }
    
    @objc func doneButtonAction() {
        self.tableView.setEditing(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonAction))
    }
    
    //MARK - Add contact data in model
    func passData(value: [String: Any], groupName: Int) {
        switch groupName {
        case 0: friends.append(value)
        case 1: family.append(value)
        case 2: colleagues.append(value)
        case 3: other.append(value)
        default: return
        }
        self.tableView.reloadData()
    }
    
    //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return friends.count
        case 1: return family.count
        case 2: return colleagues.count
        case 3: return other.count
        default: return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCell
        
        switch indexPath.section {
        case 0:
            cell.contactLabelList.text = friends[indexPath.row]["name"] as? String
            cell.contactPhotoList.image = friends[indexPath.row]["avatar"] as? UIImage
        case 1:
            cell.contactLabelList.text = family[indexPath.row]["name"] as? String
            cell.contactPhotoList.image = family[indexPath.row]["avatar"] as? UIImage
        case 2:
            cell.contactLabelList.text = colleagues[indexPath.row]["name"] as? String
            cell.contactPhotoList.image = colleagues[indexPath.row]["avatar"] as? UIImage
        case 3:
            cell.contactLabelList.text = other[indexPath.row]["name"] as? String
            cell.contactPhotoList.image = other[indexPath.row]["avatar"] as? UIImage
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.contactSections[section] as String
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerID") as? ViewController {
            switch indexPath.section {
                case 0: vc.takeName = friends[indexPath.row]["name"] as? String
                        vc.takeAvatar = friends[indexPath.row]["avatar"] as? UIImage
                        vc.takeMobile = friends[indexPath.row]["mobile"] as? String
                        vc.takeEmail = friends[indexPath.row]["email"] as? String
                        vc.takeNotes = friends[indexPath.row]["notes"] as? String
                
                case 1: vc.takeName = family[indexPath.row]["name"] as? String
                        vc.takeAvatar = family[indexPath.row]["avatar"] as? UIImage
                        vc.takeMobile = family[indexPath.row]["mobile"] as? String
                        vc.takeEmail = family[indexPath.row]["email"] as? String
                        vc.takeNotes = family[indexPath.row]["notes"] as? String
                    
                case 2: vc.takeName = colleagues[indexPath.row]["name"] as? String
                        vc.takeAvatar = colleagues[indexPath.row]["avatar"] as? UIImage
                        vc.takeMobile = colleagues[indexPath.row]["mobile"] as? String
                        vc.takeEmail = colleagues[indexPath.row]["email"] as? String
                        vc.takeNotes = colleagues[indexPath.row]["notes"] as? String
                
                case 3: vc.takeName = other[indexPath.row]["name"] as? String
                        vc.takeAvatar = other[indexPath.row]["avatar"] as? UIImage
                        vc.takeMobile = other[indexPath.row]["mobile"] as? String
                        vc.takeEmail = other[indexPath.row]["email"] as? String
                        vc.takeNotes = other[indexPath.row]["notes"] as? String
                default:
                    print("Error with take data.")
            }
            vc.indexPath = indexPath
            vc.passDelegate = self //  передаем данные для вызова делегата в дальнейшем
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            switch indexPath.section {
            case 0: friends.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            case 1: family.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            case 2: colleagues.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            case 3: other.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            default: return
            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
