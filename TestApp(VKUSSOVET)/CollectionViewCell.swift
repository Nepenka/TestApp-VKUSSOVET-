//
//  CollectionViewCell.swift
//  TestApp(VKUSSOVET)
//
//  Created by 123 on 16.01.24.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage

class CollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let subMenuCountLabel: UILabel = {
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
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(subMenuCountLabel)
        
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
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.textColor = .black
        subMenuCountLabel.text = "\(menu.subMenuCount) товаров"

        guard let imageURL = URL(string: menu.image) else {
            imageView.image = UIImage(named: "placeholder")
            print("Invalid image URL, using placeholder")
            return
        }

        
        imageView.af.setImage(withURL: imageURL, placeholderImage: UIImage(named: "placeholder"), completion: { response in
            switch response.result {
            case .success:
                print("Image loaded successfully")
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        })
    }
}
