//
//  TableViewCell.swift
//  training-ios
//
//  Created by Bui Trung Quan on 18/10/2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let identifier = "TableViewCell"
    
    private lazy var imageMovie: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "movie")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var nameMovie: UILabel = {
        let label = UILabel()
        label.text = "Iron Man: Extremis"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = createStackView(numStar: 4)
        return view
    }()
    
    private func createStackView(numStar: Int) -> UIStackView {
        let stackView = UIStackView()
        
        for i in 1..<6 {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "star.fill")
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = i>numStar ? UIColor(hex: "979797") : UIColor(hex: "FFC109")
            
            stackView.addArrangedSubview(imageView)
        }
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        
        return stackView
    }
    
    private lazy var nameAuthor: UILabel = {
        let label = UILabel()
        label.text = "Tác giả: Warren Ellis"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var nameCategory: UILabel = {
        let label = UILabel()
        label.text = "Thể loại: Siêu Anh Hùng"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var buttonNumView: UIButton = {
        let button = UIButton()
        button.setTitle("Lượt xem: 35.895.190", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.backgroundColor = UIColor(hex: "979797")
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 0,left: 12,bottom: 0,right: 12)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupSubView()
        print("TableViewCell init")
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupSubView() {
        setupImageMovie()
        setupNameMovie()
        setupStackView()
        setupNameAuthor()
        setupNameCategory()
        setupButtonNumView()
    }
    
    private func setupImageMovie() {
        addSubview(imageMovie)
        
        imageMovie.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(138.5)
            make.top.left.equalTo(self).inset(16)
            make.bottom.equalTo(self).inset(16).priority(999)
        }
    }
    
    private func setupNameMovie() {
        addSubview(nameMovie)
        
        nameMovie.snp.makeConstraints { make in
            make.left.equalTo(imageMovie.snp.right).inset(-20)
            make.top.equalTo(imageMovie).inset(6)
            make.right.equalTo(self).inset(16)
        }
    }
    
    private func setupStackView() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(imageMovie.snp.right).inset(-20)
            make.top.equalTo(nameMovie.snp.bottom).inset(-8)
        }
    }
    
    private func setupNameAuthor() {
        addSubview(nameAuthor)
        
        nameAuthor.snp.makeConstraints { make in
            make.left.equalTo(imageMovie.snp.right).inset(-20)
            make.top.equalTo(stackView.snp.bottom).inset(-12)
            make.right.equalTo(self).inset(16)
        }
    }
    
    private func setupNameCategory() {
        addSubview(nameCategory)
        
        nameCategory.snp.makeConstraints { make in
            make.left.equalTo(imageMovie.snp.right).inset(-20)
            make.top.equalTo(nameAuthor.snp.bottom).inset(-12)
            make.right.equalTo(self).inset(16)
        }
    }
    
    private func setupButtonNumView() {
        addSubview(buttonNumView)
        
        buttonNumView.snp.makeConstraints { make in
            make.left.equalTo(imageMovie.snp.right).inset(-20)
            make.top.equalTo(nameCategory.snp.bottom).inset(-12)
            make.height.equalTo(20)
        }
    }
}
