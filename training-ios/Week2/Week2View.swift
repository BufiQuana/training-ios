//
//  Week2View.swift
//  training-ios
//
//  Created by Bui Trung Quan on 18/10/2023.
//

import UIKit

class Week2View: UIView {
    weak var week2Delegate: Week2Delegate?
    
    var timeFormatted: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: Date())
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "Placeholder"
        textView.textColor = UIColor.lightGray
        textView.delegate = self
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        
        button.setBackgroundImage(UIImage.imageWithColor(color: .blue.withAlphaComponent(0.7)), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: .blue.withAlphaComponent(0.5)), for: .highlighted)
        
        return button
    }()
    
    @objc func handleButton() {
        if textView.text == "" || textView.textColor == .lightGray {
            let alert = UIAlertController(title: "Lỗi", message: "Hãy nhập text", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: handleOk)
            let cancel = UIAlertAction(title: "Huỷ", style: .destructive, handler: handleCancel)
            alert.addAction(cancel)
            alert.addAction(ok)
            week2Delegate?.presentAlert(alert: alert)
        } else {
            print(textView.text ?? "")
            textView.text = ""
        }
    }
    
    func handleOk(sender: UIAlertAction) {
        print("Ok")
    }
    
    func handleCancel(sender: UIAlertAction) {
        print("Huỷ")
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "meo")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale.init(identifier: "en_gb")
        datePicker.subviews.first?.subviews.last?.layer.cornerRadius = 4
        datePicker.subviews.first?.subviews.last?.backgroundColor = .yellow.withAlphaComponent(0.3)
        datePicker.subviews.first?.subviews.last?.layer.borderWidth = 1
        datePicker.subviews.first?.subviews.last?.layer.borderColor = UIColor.black.cgColor
        datePicker.subviews.first?.subviews.last?.tintColor = UIColor.black
        datePicker.tintColor = UIColor.black
        datePicker.addTarget(self, action: #selector(self.handleDatePicker(sender:)), for: .valueChanged)
        return datePicker
    }()
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "dd-MM-yyyy, HH:mm:ss"
        
        let strDate = timeFormatter.string(from: sender.date)
        textView.text = strDate
        textView.textColor = UIColor.black
    }
    
    private lazy var buttonTable: UIButton = {
        let button = UIButton()
        button.setTitle("UITableView", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleButtonTable), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    @objc func handleButtonTable() {
        let vc = Week2TableViewController()
        week2Delegate?.pushController(vc: vc)
    }
    
    private lazy var buttonCollection: UIButton = {
        let button = UIButton()
        button.setTitle("UICollectionView", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleButtonCollection), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    @objc func handleButtonCollection() {
        let vc = Week2CollectionViewController()
        week2Delegate?.pushController(vc: vc)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupSubView() {
        setupTextView()
        setupButton()
        setupImageView()
        setupDatePicker()
        setupButtonTable()
        setupButtonCollection()
    }
    
    private func setupTextView() {
        self.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(16)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(16)
            make.height.equalTo(80)
        }
    }
    
    private func setupButton() {
        self.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).inset(-16)
            make.centerX.equalTo(self)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
    }
    
    private func setupImageView() {
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(button.snp.bottom).inset(-16)
            make.width.equalTo(210)
            make.height.equalTo(110)
        }
    }
    
    private func setupDatePicker() {
        self.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).inset(-16)
            make.height.equalTo(160)
        }
    }
    
    private func setupButtonTable() {
        self.addSubview(buttonTable)
        
        buttonTable.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).inset(-16)
            make.left.equalTo(self).inset(16)
            make.width.equalTo(self.snp.width).dividedBy(2).offset(-24)
            make.height.equalTo(40)
        }
    }
    
    private func setupButtonCollection() {
        self.addSubview(buttonCollection)
        
        buttonCollection.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).inset(-16)
            make.right.equalTo(self).inset(16)
            make.width.equalTo(self.snp.width).dividedBy(2).offset(-24)
            make.height.equalTo(40)
        }
    }
}

extension Week2View: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
}
