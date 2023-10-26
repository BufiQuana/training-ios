//
//  PagerViewCell.swift
//  training-ios
//
//  Created by Bui Trung Quan on 23/10/2023.
//

import UIKit
import FSPagerView

class PagerViewCell: FSPagerViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var meo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureMeo(string: String) {
        self.meo.image = UIImage(named: string)
    }
    
    func configureLabel(string: String) {
        self.label.text = string
    }
}
