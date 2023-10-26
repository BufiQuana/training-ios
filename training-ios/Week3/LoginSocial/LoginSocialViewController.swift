//
//  LoginSocialViewController.swift
//  training-ios
//
//  Created by Bui Trung Quan on 23/10/2023.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FacebookLogin
import FirebaseMessaging

class LoginSocialViewController: UIViewController {

    @IBOutlet weak var signInGGButton: GIDSignInButton!

    
    @IBAction func handleGG(_ sender: Any) {
        setupGoogle()
    }
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var helloUser: UILabel!
    
    @IBAction func buttonFB(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: self) { result, error in
            if let error = error {
                print("Encountered Erorr: \(error)")
            } else if let result = result, result.isCancelled {
                print("Cancelled")
            } else {
                print("Logged In")
                guard let imageURL = Profile.current?.imageURL, let name = Profile.current?.name else { return }
                self.helloUser.text = "Hello Facebook \(name)"
                self.avatarUser.load(url: imageURL)
                let ref = Database.database().reference()
                guard let userId = Profile.current?.userID, let name = Profile.current?.name else { return }
                ref.child("users").child("Facebook").child(userId).setValue(["username": name])
            }
        }
    }
    
    @IBAction func handleLogout(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        print("Logout")
    }
    //        private lazy var buttonFB: FBLoginButton = {
//        let button = FBLoginButton()
//        button.delegate = self
//        return button
//    }()
//
//    private func setupButtonFB() {
//        view.addSubview(buttonFB)
//
//        buttonFB.snp.makeConstraints { make in
//            make.height.equalTo(48)
//            make.left.right.equalTo(view).inset(16)
//            make.centerY.equalTo(view.snp.centerY).offset(96)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStorage()
        
        setupDatabase()
//        setupButtonFB()
        let messaging = Messaging.messaging()
        messaging.subscribe(toTopic: "")
    }
    
    func setupDatabase() {
        let ref = Database.database().reference()
        
        ref.child("users/\(1)/username").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            let userName = snapshot?.value as? String ?? "Unknown";
            self.helloUser.text = "Hello Database \(userName)"
        });
        
        ref.child("users").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            let value = snapshot?.value as? [String: [String: Any]]
            
            value?["Facebook"]?.forEach({ key,value in
                print("Key: ", key)
                print("Value: ", value)
            })
            
        });
    }
    
    func setupStorage() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let testRef = storageRef.child("images/meo.jpg")
        
        testRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                // TODO
            } else {
                // TODO
                self.avatarUser.image = UIImage(data: data!)
            }
        }
    }
    
    func setupGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            // ...
            
            Auth.auth().signIn(with: credential) { authResult, error in
                
                guard let user = authResult?.user,let photoURL = user.photoURL else {return}
                self.helloUser.text = "Hello Google \(authResult?.user.displayName ?? "...")"
                self.avatarUser.load(url: photoURL)
                
                let ref = Database.database().reference()
                ref.child("users").child("Google").child(user.uid).setValue(["username": user.displayName])
                print("Sucessfully login in")
            }
        }
    }
}
