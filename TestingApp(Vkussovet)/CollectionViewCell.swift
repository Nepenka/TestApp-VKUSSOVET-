//
//  CollectionViewCell.swift
//  TestingApp(Vkussovet)
//
//  Created by 123 on 15.01.24.
//

import UIKit
import SnapKit


class CollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            label.textColor = .black
            return label
        }()
        
        let subMenuCountLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = .gray
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            addSubview(imageView)
            addSubview(nameLabel)
            addSubview(subMenuCountLabel)
            
            imageView.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(80)
            }
            
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(8)
                make.leading.trailing.equalToSuperview()
            }
            
            subMenuCountLabel.snp.makeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(4)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    
    func configure(with menu: MenuItem) {
        nameLabel.text = menu.name
        subMenuCountLabel.text = "Submenus: \(menu.subMenuCount)"

        if let imageURL = URL(string: menu.image),
            let imageData = try? Data(contentsOf: imageURL),
            let image = UIImage(data: imageData) {
            imageView.image = image
            print("Image loaded successfully")
        } else {
            imageView.image = UIImage(named: "placeholder")
            print("Image not loaded, using placeholder")
        }
    }

}
