//
//  PageCell.swift
//  Programmatic Autolayout
//
//  Created by Charles Martin Reed on 12/8/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return } //because named: constructor needs a non-optional, we'll unwrap with guard let
            
            iconImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.gray]))
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    //MARK:- UI Properties
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Cactus"))
        imageView.translatesAutoresizingMaskIntoConstraints = false //enables autolayout for imageView
        imageView.contentMode = .scaleAspectFit //w and h stay the same regardless of imageView size
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Welcome to Aspira! Let's walk through the onboarding process - don't worry, it'll be brief!", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n\nAre you ready? You'll need access to your assigned work computer and, if applicable, your assigned iPhone. If you have not yet received those, please contact your branch IT department for assistance.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false //no keyboard
        textView.isScrollEnabled = false
        return textView
    }()
    
    //private means only the enclosing declaration and extensions of this declaration IN THE SAME SOURCE file can use this
    private let previousButton: UIButton = {
        let button = UIButton(type: .system) //"system" styled button
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system) //"system" styled button
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.mainPink, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(displayP3Red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        
        return pc
    }()

    //MARK:- Init statements
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupBottomControls()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- UI Layout method
    private func setupLayout() {
        //MARK:- Container and constraints for container
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK:- Building Anchor constraints
        //multiplier on heightAnchor means 1/2 of the parent view size - we also get landscape orientation handling with this sort of programmatic layout work
        //leading and trailing over left and right because certain languages are read right-to-left. Leading and trailing handle this use case.
        let topImageContainerConstraints = [
            topImageContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topImageContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topImageContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)]
        
        topImageContainerView.addSubview(iconImageView)
        
        //iconImageView is now contained within our topImageContainerView
        let iconConstraints = [
            iconImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5)]
        
        addSubview(descriptionTextView)
        let textViewConstraints = [
            descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor)]
        
        NSLayoutConstraint.activate(topImageContainerConstraints)
        NSLayoutConstraint.activate(iconConstraints)
        NSLayoutConstraint.activate(textViewConstraints)
    }
    
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
        
        addSubview(bottomControlsStackView)
        
        //anchor at top, left and right. Respect the notch and home area!
        let buttonConstrants = [
            bottomControlsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)]
        
        NSLayoutConstraint.activate(buttonConstrants)
    }
}
