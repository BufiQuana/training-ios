//
//  Week4ViewController.swift
//  training-ios
//
//  Created by Bui Trung Quan on 26/10/2023.
//

import UIKit
import FacebookLogin
import ZaloSDK
import CryptoKit
import CommonCrypto
import SafariServices
import Alamofire

protocol Week4Delegate: AnyObject {
    func getOAuthCode(_ code: String)
}

class Week4ViewController: UIViewController {

    var verifier: String? = nil

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var avatarUser: UIImageView!
    
    @IBAction func handleZalo(_ sender: Any) {
        ZaloSDK.sharedInstance().authenticateZalo(with: .init(1), parentController: self, codeChallenge: getCodeChallenge(), extInfo: [:]) { [self] response in
            if let oauthCode = response?.oauthCode {
                ZaloSDK.sharedInstance().getAccessToken(withOAuthCode: oauthCode, codeVerifier: self.verifier) { (tokenResponse) in
                    if let tokenResponse = tokenResponse,
                       tokenResponse.isSucess {
                        print("Success")
                        APIFetchHandler.shared.access_token = tokenResponse.accessToken
                        APIFetchHandler.shared.getDataZalo {name,url in
                            self.userName.text = name
                            if let url = URL(string: url) {
                                self.avatarUser.load(url: url)
                            }
                        }
                    } else {
                        print("Fail")
                    }
                }
            }
        }
    }
    @IBAction func handleInstagram(_ sender: Any) {
        let urlString = "https://api.instagram.com/oauth/authorize/?client_id=\(Global.shared.clientId)&redirect_uri=\(Global.shared.redirectUri)&response_type=code&scope=user_profile,user_media"
        if let url = URL(string: urlString) {
            let vc = WKBrowserController()
            vc.week4Delegate = self
            vc.webURL = url
            self.present(vc, animated: true)
//            let safari: SFSafariViewController = SFSafariViewController(url: url)
//            safari.delegate = self
//            self.present(safari, animated: true, completion: nil)
        }
    }
    @IBAction func handleLogout(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        self.userName.text = Profile.current?.name ?? "Anonymous"
        self.avatarUser.image = UIImage(systemName: "person.circle.fill")
    }
    
    func createCodeVerifier() {
        var buffer = [UInt8](repeating: 0, count: 32)
        _ = SecRandomCopyBytes(kSecRandomDefault, buffer.count, &buffer)
        verifier = Data(buffer).base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
            .trimmingCharacters(in: .whitespaces)
    }
    
    func getCodeChallenge() -> String {
        guard let data = verifier?.data(using: .ascii) else { return "" }
        var buffer = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(data.count), &buffer)
        }
        let hash = Data(buffer)
        let challenge = hash.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
            .trimmingCharacters(in: .whitespaces)
        return challenge
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCodeVerifier()
    }
}

extension Week4ViewController: SFSafariViewControllerDelegate {
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        print(URL)
    }
}

extension Week4ViewController: Week4Delegate {
    func getOAuthCode(_ code: String) {
        
        self.dismiss(animated: true)
        APIFetchHandler.shared.getAccessTokenInstagram(code: code) { name in
            self.userName.text = name
        }
    }
}
