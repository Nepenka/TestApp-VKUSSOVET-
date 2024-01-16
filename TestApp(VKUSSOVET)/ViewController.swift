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
    let phoneButton = UIButton()
    let logoImageView = UIImageView()
    let titleLabel = UILabel()

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.layer.borderWidth = 2.0
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.layer.cornerRadius = 5
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(150)
           
        }
        
        networking.fetchData { items in
            DispatchQueue.main.async {
                self.menuItems = items
                collectionView.reloadData()
                print("Fetched items: \(items)")
                print("Number of menu items: \(items.count)")

            }
        }
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(phoneButton)
        
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
        
        
    }
    
    @objc func phoneButtonAction() {
        let vc = PhoneController()
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networking.menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as? CollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        }
        
        let menu = networking.menuItems[indexPath.item]
            cell.configure(with: menu)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    
}
