//
//  SwipingController.swift
//  Programmatic Autolayout
//
//  Created by Charles Martin Reed on 12/8/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        //register a custom cell to implement our custom pages
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        //enable pagination for individual cells - this allows the familiar "snapping" behavior one expects when switching between pages.
        collectionView.isPagingEnabled = true
    }
    
    //MARK:- CollectionView Delegate methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 //number of screens in our app, basically
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        //color array for testing purposes
        //let colors: [UIColor] = [.red, .orange, .yellow, .green]
        //cell.backgroundColor = colors[indexPath.item]
        
        //cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout delegate methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //cells should be the entire width and height of the parent view
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
