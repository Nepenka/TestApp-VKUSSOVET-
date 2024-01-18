//
//  SecondViewController.swift
//  TestApp(VKUSSOVET)
//
//  Created by 123 on 18.01.24.
//

import UIKit
import SnapKit




class SecondViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var firstView = ViewController()
    var dishesList: [DishesList] = []
    let networking2 = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell2.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.borderWidth = 2.0
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.layer.cornerRadius = 5
        collectionView.backgroundColor = .systemGray3
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(200)
        }
    }
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networking2.dishesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell2 else {
            return UICollectionViewCell()
        }
        
        let dish = networking2.dishesList[indexPath.item]
        cell.configure1(with: dish)
        
        return cell
    }
}
