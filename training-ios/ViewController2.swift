//
//  ViewController2.swift
//  training-ios
//
//  Created by Bui Trung Quan on 16/10/2023.
//

import UIKit

class ViewController2: UIViewController {
    
    private lazy var buttonBack: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(tapHandle), for: .touchUpInside)
        
        return button
    }()
    
    @objc func tapHandle() {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad 2")
        view.backgroundColor = .red
        setupButtonBack()
    }
    override func loadView() {
        super.loadView()
        print("loadView 2")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear 2")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear 2")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear 2")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear 2")
    }

    private func setupButtonBack() {
        self.view.addSubview(buttonBack)
        
        buttonBack.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
}
