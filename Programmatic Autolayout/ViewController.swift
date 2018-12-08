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
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
      let textView = UITextView()
        textView.text = "Welcome to Aspira! Let's walk through the onboarding process - don't worry, it'll be brief!"
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false //no keyboard
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(iconImageView)
        view.addSubview(descriptionTextView)
        
        setupLayout()
        
    }
    
    private func setupLayout() {
        //MARK:- Building Anchor constraints
        //placed in the center X, 100 from the top in Y axis
        let iconConstraints = [iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), iconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100), iconImageView.widthAnchor.constraint(equalToConstant: 200), iconImageView.heightAnchor.constraint(equalToConstant: 200)]
        
        let textViewConstraints = [descriptionTextView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 120), descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor), descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor), descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        
        NSLayoutConstraint.activate(iconConstraints)
        NSLayoutConstraint.activate(textViewConstraints)
    }


}

