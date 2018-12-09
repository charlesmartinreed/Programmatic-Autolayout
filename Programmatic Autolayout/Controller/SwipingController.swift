//
//  SwipingController.swift
//  Programmatic Autolayout
//
//  Created by Charles Martin Reed on 12/8/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: Page model induction
    let pages = [
        Page(imageName: "Cactus", headerText: "Welcome to Aspira!", bodyText: "There is no real reason to be creative here."),
        Page(imageName: "Directions", headerText: "We make work feel like play!", bodyText: "So guess what? I'm going to mail it in."),
        Page(imageName: "Field", headerText: "We're glad to have you as a part of our family!", bodyText: "If you're reading this, you must be really bored and cruising Github."),
        Page(imageName: "Nightdesert", headerText: "Here are some important contacts:", bodyText: "Please forgive any obvious mistakes, I'm but a humble Swift apprentice.")
    ]
    
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
    
    //MARK:- UICollectionViewDelegateFlowLayout delegate methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //cells should be the entire width and height of the parent view
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
