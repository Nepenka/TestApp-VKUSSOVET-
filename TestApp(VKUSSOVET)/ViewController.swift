//
//  ViewController.swift
//  TestApp(VKUSSOVET)
//
//  Created by 123 on 16.01.24.
//

import UIKit
import SnapKit



class ViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - UI Components
    let networking = Networking()
    var menuItems: [MenuItem] = []
    var dishLists: [DishesList] = []
    let phoneButton = UIButton()
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    var collectionView: UICollectionView!
    var headingLabel = UILabel()
    var dishesCollectionView: UICollectionView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupUI()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10
        collectionView.showsHorizontalScrollIndicator = false

        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(150)
        }

        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .vertical
        dishesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout2)
        dishesCollectionView.register(CollectionViewCell2.self, forCellWithReuseIdentifier: "cell")
        dishesCollectionView.backgroundColor = .white
        dishesCollectionView.delegate = self
        dishesCollectionView.dataSource = self

        
        view.addSubview(dishesCollectionView)
        dishesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(350)
        }

        
        
        networking.completionHandler = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            if let firstMenu = self.networking.menuItems.first {
                UIView.animate(withDuration: 0.3, animations: {
                    self.headingLabel.alpha = 0.0
                }) { (_) in
                    self.headingLabel.text = firstMenu.name
                    UIView.animate(withDuration: 0.3, animations: {
                        self.headingLabel.alpha = 1.0
                    })
                }
            }
        }
        
        /*
        networking.completionHandler = { [weak self] in
            guard let self = self else {return}
            self.dishesCollectionView.reloadData()
            self.dishLists = self.networking.dishesList
        }
        */
        
        //networking.fetchDataForAnotherCollectionView()
        networking.fetchData()
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(phoneButton)
        view.addSubview(headingLabel)
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "logo1")
        
        logoImageView.snp.makeConstraints { image in
            image.top.equalToSuperview().offset(40)
            image.left.equalToSuperview().offset(-5)
            image.width.height.equalTo(90)
        }
        
        titleLabel.text = "VKUSSOVET"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 23)
        titleLabel.textColor = .black
        
        titleLabel.snp.makeConstraints { label in
            label.centerY.equalTo(logoImageView)
            label.left.equalTo(logoImageView.snp.right).offset(-6)
        }
        
        
        let phoneImage = UIImage(systemName: "phone.fill")
        phoneButton.setImage(phoneImage, for: .normal)
        phoneButton.imageView?.contentMode = .scaleAspectFit
        phoneButton.tintColor = .black
        let increasedTouchArea: CGFloat = 15.0
        phoneButton.contentEdgeInsets = UIEdgeInsets(top: increasedTouchArea, left: increasedTouchArea, bottom: increasedTouchArea, right: increasedTouchArea)
        phoneButton.addTarget(self, action: #selector(phoneButtonAction), for: .touchUpInside)
        
        phoneButton.snp.makeConstraints { phone in
            phone.centerY.equalTo(logoImageView)
            phone.left.equalTo(titleLabel.snp.right).offset(85)
        }
        
        
        headingLabel.text = ""
        headingLabel.font = UIFont(name: "Helvetica-Bold", size: 27)
        headingLabel.textColor = .black
        headingLabel.numberOfLines = 0
        headingLabel.lineBreakMode = .byWordWrapping
        headingLabel.snp.makeConstraints { heading in
            heading.top.equalTo(logoImageView.snp.bottom).offset(180)
            heading.left.right.equalToSuperview().inset(15)
        }
        
        
    }
    
    @objc func phoneButtonAction() {
        let vc = PhoneController()
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dishesCollectionView {
            return networking.dishesList.count
        } else {
            return networking.menuItems.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dishesCollectionView {
            guard let cell2 = dishesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell2 else {
                return UICollectionViewCell()
            }
            
            let dish = networking.dishesList[indexPath.item]
            cell2.configure1(with: dish)
            cell2.backgroundColor = UIColor.systemGray3
            
            
            return cell2
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
                return UICollectionViewCell()
            }
            let menu = networking.menuItems[indexPath.item]
            cell.configure(with: menu)
            cell.backgroundColor = UIColor.systemGray3
            
            return cell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing = 5
        let numberOfColumns = 3
        
        let cellWidth = (collectionViewWidth - CGFloat(numberOfColumns - 1) * CGFloat(spacing)) / CGFloat(numberOfColumns)
        let cellHeight = collectionView.bounds.height - 10

        return CGSize(width: cellWidth, height: cellHeight)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMenu = networking.menuItems[indexPath.item]
            UIView.animate(withDuration: 0.3, animations: {
                self.headingLabel.alpha = 0.0
            }) { (_) in
                self.headingLabel.text = selectedMenu.name
                UIView.animate(withDuration: 0.3, animations: {
                    self.headingLabel.alpha = 1.0
                })
            }
    }
}


