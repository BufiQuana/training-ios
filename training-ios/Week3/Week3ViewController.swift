//
//  Week3ViewController.swift
//  training-ios
//
//  Created by Bui Trung Quan on 20/10/2023.
//

import UIKit

protocol Week3Delegate: AnyObject {
    func setNavigationBarHidden(_ bool: Bool)
}

class Week3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(passData), name: NSNotification.Name("passData"), object: nil)
        
        let week3View = Week3View()
        week3View.week3Delegate = self
        week3View.closure = { [unowned self] bool in
            self.navigationController?.setNavigationBarHidden(bool, animated: true)
        }
        self.view = week3View
    }
    
    @objc func passData(_ notification: Notification) {
        let object = notification.object as? Bool
        guard let object = object else { return }
        self.navigationController?.setNavigationBarHidden(object, animated: true)
    }
}

extension Week3ViewController: Week3Delegate {
    func setNavigationBarHidden(_ bool: Bool) {
        self.navigationController?.setNavigationBarHidden(bool, animated: true)
    }
}
