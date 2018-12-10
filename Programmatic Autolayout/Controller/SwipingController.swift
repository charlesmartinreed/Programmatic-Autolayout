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
    
    //private means only the enclosing declaration and extensions of this declaration IN THE SAME SOURCE file can use this
    private let previousButton: UIButton = {
        let button = UIButton(type: .system) //"system" styled button
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        
        //target action
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system) //"system" styled button
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.mainPink, for: .normal)
        
        //target action
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(displayP3Red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        
        return pc
    }()
    
    //MARK:- Button next/previous methods
    @objc private func handlePrev() {
        let prevIndex = max(pageControl.currentPage - 1, 0) //at first page, (-1 vs 0), so defaults to page 0
        
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1) //starts at zero, incremented each func call
        
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    //fileprivate = for use only within the defining source file
    //MARK:- Button layout method
    fileprivate func setupBottomControls() {
        //view.addSubview(previousButton)
        
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let orangeView = UIView()
        orangeView.backgroundColor = .orange
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        //anchor at top, left and right. Respect the notch and home area!
        let buttonConstrants = [
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)]
        
        NSLayoutConstraint.activate(buttonConstrants)
    }
    
    //scroll view methods, collection view inherits this
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //content offset - pointee is the value contained with the pointer, represents where the scroll view will stop dragging
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        
        //for our use case, because the screens are laid out horizontally, the view.frame.width is equivalent to the number of pages' * each pages width. Dividing by x gives us the page number.
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls()
        
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
