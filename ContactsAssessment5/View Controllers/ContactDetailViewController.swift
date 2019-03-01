//
//  ContactDetailViewController.swift
//  ContactsAssessment5
//
//  Created by Cameron Milliken on 3/1/19.
//  Copyright © 2019 Cameron Milliken. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    //Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
            let phoneNumber = phoneNumberTextField.text,
            let email = emailTextField.text else { return }
        if let contact = contact {
            ContactController.shared.updateContact(contact: contact, name: name, phoneNumber: Int(phoneNumber) ?? 0, email: email) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            ContactController.shared.createContactWith(name: name, phoneNumber: Int(phoneNumber) ?? 0, email: email) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    // Update Views
    func updateViews(){
        guard let contact = contact, let phoneNumber = contact.phoneNumber else { return }
        nameTextField.text = contact.name
        phoneNumberTextField.text = "\(phoneNumber)"
        emailTextField.text = contact.email
        
    }
    
 

} // End of Class
