//
//  ViewController.swift
//  TestingApp(Vkussovet)
//
//  Created by 123 on 15.01.24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: - UI Setup
    let networking = Networking()
    let authHeaderView = AuthHeaderView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
    var menuItems: [MenuItem] = []
    let phoneButton = UIButton()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .systemBackground
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.titleView = authHeaderView
        
        view.addSubview(collectionView)
        collectionView.layer.borderWidth = 2.0
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
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
    
    private func setupUI() {
        view.addSubview(phoneButton)
        let phoneImage = UIImage(systemName: "phone.fill")
        phoneButton.setImage(phoneImage, for: .normal)
        phoneButton.imageView?.contentMode = .scaleAspectFit
        phoneButton.tintColor = .black
        let increasedTouchArea: CGFloat = 10.0
        phoneButton.contentEdgeInsets = UIEdgeInsets(top: increasedTouchArea, left: increasedTouchArea, bottom: increasedTouchArea, right: increasedTouchArea)
        phoneButton.addTarget(self, action: #selector(phoneButtonAction), for: .touchUpInside)
        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        
        phoneButton.snp.makeConstraints { phone in
            phone.top.equalToSuperview().offset(60)
            phone.right.equalToSuperview().offset(4)
            phone.width.height.equalTo(70)
        }
    }
    
    
    @objc func phoneButtonAction() {
       let vc = PhoneController()
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }

    
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networking.menuItems.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }

        let menu = networking.menuItems[indexPath.item]
        print("Configuring cell for item at index \(indexPath.item) with menu: \(menu)")
        cell.configure(with: menu)

        return cell
    }

}

