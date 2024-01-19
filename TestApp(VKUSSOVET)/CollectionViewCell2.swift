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
        nameLabel.textColor = .white
        return nameLabel
    }()
    
    private let contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textAlignment = .center
        contentLabel.font = UIFont.systemFont(ofSize: 12)
        contentLabel.textColor = .gray
        contentLabel.numberOfLines = 3
        contentLabel.lineBreakMode = .byTruncatingTail
        return contentLabel
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        priceLabel.textColor = .white
        return priceLabel
    }()
    
    private let weightLabel: UILabel = {
        let weightLabel = UILabel()
        weightLabel.textAlignment = .center
        weightLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        weightLabel.textColor = .gray
        return weightLabel
    }()
    
    private let spicyIconImageView: UIImageView = {
        let spicyIconImageView = UIImageView()
        spicyIconImageView.contentMode = .scaleAspectFit
        spicyIconImageView.clipsToBounds = true
        return spicyIconImageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private let buttonAction: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("В корзину", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(contentLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(weightLabel)
        containerView.addSubview(spicyIconImageView)
        contentView.addSubview(containerView)
        contentView.addSubview(buttonAction)

        imageView.snp.makeConstraints { image in
            image.top.equalTo(priceLabel.snp.bottom).offset(15)
            image.left.bottom.right.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { name in
            name.top.equalToSuperview().offset(10)
            name.left.right.equalToSuperview().inset(10)
        }

        contentLabel.snp.makeConstraints { content in
            content.top.equalTo(nameLabel.snp.bottom).offset(5)
            content.left.right.equalToSuperview().inset(10)
        }

        priceLabel.snp.makeConstraints { price in
            price.top.equalTo(contentLabel.snp.bottom).offset(15)
            price.left.equalToSuperview().inset(35)
            price.right.equalTo(weightLabel.snp.left).offset(-10)
        }

        weightLabel.snp.makeConstraints { weight in
            weight.top.equalTo(priceLabel)
            weight.left.equalTo(priceLabel.snp.right).offset(10)
            weight.right.lessThanOrEqualToSuperview().inset(10)
        }

        spicyIconImageView.snp.makeConstraints { spicy in
            spicy.centerY.equalTo(weightLabel)
            spicy.left.equalTo(weightLabel.snp.right).offset(-5)
            spicy.height.equalTo(40)
            spicy.width.equalTo(40)
        }
        
        containerView.snp.makeConstraints { container in
            container.top.equalToSuperview()
            container.left.right.equalToSuperview()
            container.bottom.equalToSuperview().inset(20)
        }
        
        buttonAction.snp.makeConstraints { button in
            button.bottom.equalToSuperview()
            button.left.right.equalToSuperview().inset(20)
            button.height.equalTo(50)
        }

    }
    
    func configure1(with dish: Dish) {
        nameLabel.text = dish.name
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        
        contentLabel.text = dish.content
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        
        priceLabel.text = "\(dish.price) ₽"
        weightLabel.text = "/ \(dish.weight)"
        
        if dish.spicy == "Y" {
            spicyIconImageView.image = UIImage(named: "chilli")
        } else {
            spicyIconImageView.image = nil
        }
        
        guard let imageURL = URL(string: dish.image) else {
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

