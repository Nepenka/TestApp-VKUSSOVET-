//
//  PhoneController.swift
//  TestApp(VKUSSOVET)
//
//  Created by 123 on 16.01.24.
//

import UIKit
import SnapKit

class PhoneController: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelUI()
        view.backgroundColor = .systemGray6
    }
    
    private func setupLabelUI() {
        view.addSubview(label)
        
        label.text = "Здесь мог бы быть ваш номер :("
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor.black
        
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

   
}
