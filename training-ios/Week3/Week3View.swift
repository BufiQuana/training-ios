//
//  Week3View.swift
//  training-ios
//
//  Created by Bui Trung Quan on 20/10/2023.
//

import UIKit
import WebKit
import FSPagerView

class Week3View: UIView {
    
    var closure: (Bool)->Void = {_ in}
    
    weak var week3Delegate: Week3Delegate?
    
    private lazy var buttonPrev: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var buttonNext: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handlePrev(sender: UIButton) {
        webView.goBack()
    }
    
    @objc func handleNext(sender: UIButton) {
        webView.goForward()
    }
    
    let htmlString = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="src/style.css">
    </head>
    <style>
    h1 {
    color: blue
    }
    </style>
    <body>
    
    <h1>Hi friend, try edit me!</h1>
    
    </body>
    </html>
    """
    
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.loadHTMLString(htmlString, baseURL: nil)
//        let url = URL(string: "https://www.google.com.vn")!
//        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20.0)
//        view.load(request)
        view.scrollView.bounces = false
//        view.scalesPageToFit = false
        view.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
        view.scrollView.delegate = self
        view.navigationDelegate = self
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var iconSearch: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleSearch(sender: UIButton?) {
        let urlString = searchBar.text ?? ""
        let urlHasHttpPrefix = urlString.hasPrefix("http://")
        let urlHasHttpsPrefix = urlString.hasPrefix("https://")
        let validUrlString = (urlHasHttpPrefix || urlHasHttpsPrefix) ? urlString : "https://\(urlString)"
        let url = URL(string: "\(validUrlString)")!
        if url != webView.url?.absoluteURL {
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20.0)
            webView.load(request)
        }
        else {
            print("same url")
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupSubView() {
        addSubview(buttonPrev)
        addSubview(buttonNext)
        addSubview(searchBar)
        addSubview(iconSearch)
        addSubview(webView)
        setupButtonPrev()
        setupButtonNext()
        setupSearchBar()
        setupIconSearch()
        setupWebView()
    }
    
    private func setupButtonPrev() {
        
        
        buttonPrev.snp.makeConstraints { make in
            make.left.equalTo(self).inset(16)
            make.size.equalTo(24)
            make.centerY.equalTo(searchBar)
        }
    }
    
    private func setupButtonNext() {
        
        
        buttonNext.snp.makeConstraints { make in
            make.left.equalTo(buttonPrev.snp.right).inset(-4)
            make.size.equalTo(24)
            make.centerY.equalTo(searchBar)
        }
    }
    
    private func setupSearchBar() {
        
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(48)
            make.left.equalTo(buttonNext.snp.right).inset(-8)
            make.right.equalTo(self).inset(56)
        }
    }
    
    private func setupIconSearch() {
        
        
        iconSearch.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.right.equalTo(self).inset(16)
            make.centerY.equalTo(searchBar)
        }
    }
    
    private func setupWebView() {
        
        
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(searchBar.snp.bottom).inset(-16)
        }
    }
}

extension Week3View: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0
        {
            self.week3Delegate?.setNavigationBarHidden(false)
//            self.closure(false)
//            NotificationCenter.default.post(name: NSNotification.Name("passData"), object: false)
        }
        else
        {
            self.week3Delegate?.setNavigationBarHidden(true)
//            self.closure(true)
//            NotificationCenter.default.post(name: NSNotification.Name("passData"), object: true)
        }
    }
}

extension Week3View: WKNavigationDelegate {
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { // triggers when loading is complete
        buttonPrev.isHidden = !webView.canGoBack
        buttonNext.isHidden = !webView.canGoForward
        searchBar.text = webView.url?.absoluteString
        let newPosition = searchBar.searchTextField.beginningOfDocument
        searchBar.searchTextField.selectedTextRange = searchBar.searchTextField.textRange(from: newPosition, to: newPosition)
    }
}

extension Week3View: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        handleSearch(sender: nil)
    }
}
