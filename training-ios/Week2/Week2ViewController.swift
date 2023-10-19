//
//  Week2ViewController.swift
//  training-ios
//
//  Created by Bui Trung Quan on 17/10/2023.
//

import UIKit

protocol Week2Delegate: AnyObject {
    func presentAlert(alert: UIAlertController)
    func pushController(vc: UIViewController)
}

final class Week2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func loadView() {
        let week2View = Week2View()
        week2View.week2Delegate = self
        view = week2View
    }
}

extension Week2ViewController: Week2Delegate {
    func pushController(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentAlert(alert: UIAlertController) {
        self.present(alert, animated: true)
    }
}
