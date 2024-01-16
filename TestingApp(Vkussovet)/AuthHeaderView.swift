//
//  AuthHeaderView.swift
//  TestingApp(Vkussovet)
//
//  Created by 123 on 15.01.24.
//

import UIKit
import SnapKit

class AuthHeaderView: UIView {
    //MARK: - UI Components
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo1")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "VKUSSOVET"
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 23)
        label.textColor = .black
        return label
    }()
    
    /*
    let phoneButton: UIButton = {
        let button = UIButton()
        let phoneImage = UIImage(systemName: "phone.fill")
        
        button.setImage(phoneImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        let increasedTouchArea: CGFloat = 10.0
        button.contentEdgeInsets = UIEdgeInsets(top: increasedTouchArea, left: increasedTouchArea, bottom: increasedTouchArea, right: increasedTouchArea)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    */
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        //addSubview(phoneButton)
        
        logoImageView.snp.makeConstraints { image in
            image.top.equalToSuperview().offset(6)
            image.left.equalToSuperview().offset(-5)
            image.width.height.equalTo(90)
        }
        
        titleLabel.snp.makeConstraints { label in
            label.centerY.equalTo(logoImageView)
            label.left.equalTo(logoImageView.snp.right).offset(-6)
        }
        
        /*
        phoneButton.snp.makeConstraints { phone in
            phone.centerY.equalTo(logoImageView)
            phone.left.equalTo(titleLabel.snp.right).offset(85)
        }
         */
    }


}

