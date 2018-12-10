//
//  SwipingController+UICollectionView.swift
//  Programmatic Autolayout
//
//  Created by Charles Martin Reed on 12/9/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

extension SwipingController {
    
    //MARK:- UICollectionViewDelegateFlowLayout delegate methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //cells should be the entire width and height of the parent view
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    //MARK:- CollectionView Delegate methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count //number of screens in our app, basically
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell //cast as the proper Cell class
        
        //page image
        let page = pages[indexPath.item]
        cell.page = page
        
        //since this is a controller, we pass the model object to the view
        //cell.iconImageView.image = UIImage(named: page.imageName)
        
        //page header
        //cell.descriptionTextView.text = page.headerText
        
        //cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }

}

