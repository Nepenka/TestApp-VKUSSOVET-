//
//  AuthHeaderView.swift
//  TestingApp(Vkussovet)
//
//  Created by 123 on 15.01.24.
//

import UIKit
import SnapKit



class AuthHeaderView {
    //MARK: - UI Components
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "VKUSSOVET"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
   //MARK: - LifeCycle
    init(title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        logoImageView.addSubview(logoImageView)
        titleLabel.addSubview(titleLabel)
        
        self.logoImageView.snp.makeConstraints { image in
            
        }
    }
}
