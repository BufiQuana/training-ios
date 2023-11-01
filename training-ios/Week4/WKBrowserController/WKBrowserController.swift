//
//  File.swift
//  training-ios
//
//  Created by Bui Trung Quan on 31/10/2023.
//

import UIKit
import WebKit

class WKBrowserController: UIViewController {
    
    weak var week4Delegate: Week4Delegate?
    
    var webView: WKWebView?
    var webURL: URL? { didSet {
        self.navigate()
    }
    }
    
    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigate()
    }
    
    fileprivate func navigate() {
        if let url = self.webURL {
            webView?.load(URLRequest(url: url))
        }
    }
}

extension WKBrowserController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let urlString = webView.url?.absoluteString ?? ""
        if let range = urlString.range(of: "code=") {
            let codeString = urlString[range.upperBound...]
            let code = codeString.dropLast(2)
            self.week4Delegate?.getOAuthCode(String(code))
        }
    }
}
