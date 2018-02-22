//
//  FoodGroupsViewController.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 2/21/18.
//  Copyright © 2018 JoeSuzuki. All rights reserved.
//

import UIKit

class FoodGroupsViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView?.backgroundColor = UIColor(r: 76, g: 200, b: 100)
        collectionView?.register(GroupCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationBarItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
}

