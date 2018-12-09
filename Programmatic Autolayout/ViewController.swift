//
//  ViewController.swift
//  Programmatic Autolayout
//
//  Created by Charles Martin Reed on 12/7/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Properties
    let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Cactus"))
        imageView.translatesAutoresizingMaskIntoConstraints = false //enables autolayout for imageView
        imageView.contentMode = .scaleAspectFit //w and h stay the same regardless of imageView size
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(descriptionTextView)
        
        setupLayout()
        
    }
    
    private func setupLayout() {
        //MARK:- Container and constraints for container
        let topImageContainerView = UIView()
        view.addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
       
        //MARK:- Building Anchor constraints
        //multiplier on heightAnchor means 1/2 of the parent view size - we also get landscape orientation handling with this sort of programmatic layout work
        //leading and trailing over left and right because certain languages are read right-to-left. Leading and trailing handle this use case.
        let topImageContainerConstraints = [
            topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)]
        
        topImageContainerView.addSubview(iconImageView)
        
        //iconImageView is now contained within our topImageContainerView
        let iconConstraints = [
            iconImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5)]
        
        let textViewConstraints = [
            descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        
        NSLayoutConstraint.activate(topImageContainerConstraints)
        NSLayoutConstraint.activate(iconConstraints)
        NSLayoutConstraint.activate(textViewConstraints)
    }


}
