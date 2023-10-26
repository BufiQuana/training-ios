//
//  Week3XibViewController.swift
//  training-ios
//
//  Created by Bui Trung Quan on 23/10/2023.
//

import UIKit
import WebKit
import FirebaseStorage

class Week3XibViewController: UIViewController {

    @IBAction func handleClosureAndDelegate(_ sender: Any) {
        let vc = Week3ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func handlePagerView(_ sender: Any) {
        let vc = FSPagerViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func handleLoginSocial(_ sender: Any) {
        let vc = LoginSocialViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let data = UIImage(named: "meo")?.jpegData(compressionQuality: 1) ?? Data()
        let testRef = storageRef.child("images/meo.jpg")
        
        let uploadTask = testRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            testRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
            }
        }
    }
}

extension Week3XibViewController: Week3Delegate {
    func setNavigationBarHidden(_ bool: Bool) {
        self.navigationController?.setNavigationBarHidden(bool, animated: true)
    }
}

extension Week3XibViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0
        {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        else
        {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
}
