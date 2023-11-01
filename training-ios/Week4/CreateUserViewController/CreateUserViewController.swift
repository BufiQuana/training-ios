//
//  CreateUserViewController.swift
//  training-ios
//
//  Created by Bui Trung Quan on 30/10/2023.
//

import UIKit

protocol UserDelegate: AnyObject {
    func selectedUser(user: User)
}

class CreateUserViewController: UIViewController {
    
    private var currentUser: User? = nil

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var buttonCreate: UIButton!
    @IBOutlet weak var buttonUpdate: UIButton!
    
    @IBAction func handleCreate(_ sender: Any) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let user = User(id: nil, firstName: firstName, lastName: lastName, email: email)
        APIFetchHandler.shared.createUser(user: user) {
            self.firstNameTextField.text = ""
            self.lastNameTextField.text = ""
            self.emailTextField.text = ""
        }
    }
    @IBAction func handleList(_ sender: Any) {
        let vc = UserTableViewController()
        vc.userDelegate = self
        self.currentUser = nil
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func handleUpdate(_ sender: Any) {
        if let currentUser = self.currentUser {
            let firstName = firstNameTextField.text ?? ""
            let lastName = lastNameTextField.text ?? ""
            let newUser = User(id: currentUser.id, firstName: firstName, lastName: lastName, email: nil)
            
            APIFetchHandler.shared.updateUser(user: newUser) {
                self.firstNameTextField.text = ""
                self.lastNameTextField.text = ""
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CreateUserViewController: UserDelegate {
    func selectedUser(user: User) {
        self.currentUser = user
        self.firstNameTextField.text = user.firstName
        self.lastNameTextField.text = user.lastName
    }
}
