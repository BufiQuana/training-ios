//
//  UserTableViewController.swift
//  training-ios
//
//  Created by Bui Trung Quan on 30/10/2023.
//

import UIKit

class UserTableViewController: UIViewController {
    
    weak var userDelegate: UserDelegate?
    
    private var listUser: [User] = []

    @IBOutlet weak var userTableView: UITableView! {
        didSet {
            userTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
            userTableView.delegate = self
            userTableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIFetchHandler.shared.getListUser(page: 5) { list in
            self.listUser = list
            self.userTableView.reloadData()
        }
    }
}

extension UserTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            APIFetchHandler.shared.deleteUser(user: listUser[indexPath.row]) {
                self.listUser.remove(at: indexPath.row)
                self.userTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.userDelegate?.selectedUser(user: listUser[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}

extension UserTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        let firstName = listUser[indexPath.row].firstName
        let lastName = listUser[indexPath.row].lastName
        cell.textLabel?.text = "\(firstName) \(lastName)"
        return cell
    }
}
