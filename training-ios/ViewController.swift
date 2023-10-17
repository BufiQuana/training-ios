//
//  ViewController.swift
//  training-ios
//
//  Created by Bui Trung Quan on 16/10/2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var buttonPush: UIButton = {
        let button = UIButton()
        button.setTitle("Push", for: .normal)
        button.addTarget(self, action: #selector(tapHandle), for: .touchUpInside)
        
        return button
    }()
    
    @objc func tapHandle() {
        let vc = ViewController2()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad 1")
        view.backgroundColor = .green
        setupButtonPush()
    }
    override func loadView() {
        super.loadView()
        print("loadView 1")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear 1")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear 1")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear 1")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear 1")
    }
    
    private func setupButtonPush() {
        self.view.addSubview(buttonPush)
        
        buttonPush.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
}

