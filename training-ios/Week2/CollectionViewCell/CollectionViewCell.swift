//
//  CollectionViewCell.swift
//  training-ios
//
//  Created by Bui Trung Quan on 18/10/2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    private lazy var imageMovie: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "movie")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var nameMovie: UILabel = {
        let label = UILabel()
        label.text = "Iron Man: Extremis"
        label.textColor = UIColor(hex: "FF7B00")
        label.font = .systemFont(ofSize: 8)
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
            imageView.frame.size = CGSize(width: 8, height: 8)
            
            stackView.addArrangedSubview(imageView)
        }
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        
        return stackView
    }
    
    private lazy var nameCategory: UILabel = {
        let label = UILabel()
        label.text = "Siêu Anh Hùng"
        label.textColor = .black
        label.font = .systemFont(ofSize: 6)
        return label
    }()
    
    private lazy var numViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Lượt xem: 35.895.190"
        label.textColor = .black
        label.font = .systemFont(ofSize: 6)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubView()
        print("CollectionViewCell init")
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupSubView() {
        setupImageMovie()
        setupNameMovie()
        setupNameCategory()
        setupStackView()
        setupNumViewLabel()
    }
    
    private func setupImageMovie() {
        addSubview(imageMovie)
        
        imageMovie.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(120)
            make.top.left.equalTo(self)
        }
    }
    
    private func setupNameMovie() {
        addSubview(nameMovie)
        
        nameMovie.snp.makeConstraints { make in
            make.left.equalTo(imageMovie)
            make.top.equalTo(imageMovie.snp.bottom).inset(-4)
            make.right.equalTo(self).inset(16)
        }
    }
    
    private func setupNameCategory() {
        addSubview(nameCategory)
        
        nameCategory.snp.makeConstraints { make in
            make.left.equalTo(imageMovie)
            make.top.equalTo(nameMovie.snp.bottom).inset(-4)
            make.right.equalTo(self).inset(16)
        }
    }
    
    private func setupStackView() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(imageMovie)
            make.top.equalTo(nameCategory.snp.bottom).inset(-4)
            make.height.equalTo(8)
            make.width.equalTo(60)
        }
    }
    
    private func setupNumViewLabel() {
        addSubview(numViewLabel)
        
        numViewLabel.snp.makeConstraints { make in
            make.left.equalTo(imageMovie)
            make.bottom.equalTo(self)
        }
    }
    
    func configure(movie: Movie) {
        imageMovie.image = UIImage(named: movie.image)
        nameMovie.text = movie.nameMovie
        nameCategory.text = movie.category
        numViewLabel.text = "Lượt xem: \(movie.numView)"
        
        self.stackView.removeFromSuperview()
        stackView = createStackView(numStar: movie.star)
        setupStackView()
    }
}
