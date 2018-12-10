//
//  SwipingController+extension.swift
//  Programmatic Autolayout
//
//  Created by Charles Martin Reed on 12/9/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

extension SwipingController {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        //coordinator will run an animation during the update
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout() //lets the layout redraw itself during the next view layout update cycle
            
            //iPhone X/XS screen fix for page 0 layout issue
            if self.pageControl.currentPage == 0 {
                self.collectionView.contentOffset = .zero
            } else {
                //animate back to the proper page
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }) { (_) in
            //do stuff
        }
        
        
    }
}
