//
//  FSPagerViewController.swift
//  training-ios
//
//  Created by Bui Trung Quan on 23/10/2023.
//

import UIKit
import FSPagerView

class FSPagerViewController: UIViewController {

    @IBOutlet weak var pagerView: FSPagerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.transformer = .init(type: .linear)
        pagerView.isInfinite = true
        pagerView.itemSize = CGSize(width: 100, height: 100)
        pagerView.register(UINib(nibName: "PagerViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
}

extension FSPagerViewController: FSPagerViewDelegate {
    
}

extension FSPagerViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        5
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! PagerViewCell
        cell.configureMeo(string: "meo")
        cell.configureLabel(string: "Item \(index)")
        return cell
    }
}
