//
//  CollectionViewCell2.swift
//  TestApp(VKUSSOVET)
//
//  Created by 123 on 18.01.24.
//

import UIKit
import Alamofire
import AlamofireImage
import SnapKit


class CollectionViewCell2: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        nameLabel.textColor = .black
        return nameLabel
    }()
    
    private let contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textAlignment = .center
        contentLabel.font = UIFont.systemFont(ofSize: 12)
        contentLabel.textColor = .gray
        return contentLabel
    }()
    
    private let priceLabel: UILabel = {
       let priceLabel = UILabel()
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        priceLabel.textColor = .black
        return priceLabel
    }()
    
    private let weightLabel: UILabel = {
        let weightLabel = UILabel()
        weightLabel.textAlignment = .center
        weightLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        weightLabel.textColor = .gray
        return weightLabel
    }()
    
    private let spicyIconImageView: UIImageView = {
       let spicyIconImageView = UIImageView()
        spicyIconImageView.contentMode = .scaleAspectFit
        spicyIconImageView.clipsToBounds = true
        return spicyIconImageView
    }()
    
    
    func configure1(with dish: DishesList) {
        contentView.addSubview(nameLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(weightLabel)
        contentView.addSubview(spicyIconImageView)
        contentView.addSubview(imageView)
        
        nameLabel.snp.makeConstraints { name in
            name.top.equalToSuperview().inset(20)
            name.left.right.equalToSuperview().inset(50)
        }
        
        contentLabel.snp.makeConstraints { content in
            content.top.equalTo(nameLabel.snp.bottom).offset(15)
            content.left.right.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { price in
            price.top.equalTo(contentLabel.snp.bottom).offset(40)
            price.left.right.equalToSuperview()
        }
        
        weightLabel.snp.makeConstraints { weight in
            weight.top.equalTo(priceLabel)
            weight.right.equalTo(priceLabel.snp.left).offset(-10)
        }
        
        spicyIconImageView.snp.makeConstraints { spicy in
            spicy.top.equalTo(weightLabel)
            spicy.right.equalTo(weightLabel.snp.left).offset(-10)
        }
        
        imageView.snp.makeConstraints { image in
            image.top.equalTo(priceLabel.snp.bottom).offset(40)
            image.left.right.equalToSuperview()
            image.height.equalTo(80)
        }
        
        nameLabel.text = dish.name
        contentLabel.text = dish.content
        priceLabel.text = "\(dish.price) ₽"
        weightLabel.text = "/ \(dish.weight) г."
        
        
        if dish.spicy == "Y" {
                spicyIconImageView.image = UIImage(named: "chilli")
            } else {
                spicyIconImageView.image = nil
        }
    }
    
}
