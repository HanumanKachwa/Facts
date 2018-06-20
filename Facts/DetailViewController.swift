//
//  DetailViewController.swift
//  Facts
//
//  Created by Hanuman on 21/06/18.
//  Copyright © 2018 Hanuman. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    let manager: DetailManager
    lazy var defaultImageSize = CGSize(width: (self.view.bounds.size.width * 30) / 100, height: (self.view.bounds.size.height * 70) / 100)

    let imageView: UIImageView = {
        let tempImageView = UIImageView()
        tempImageView.contentMode = .scaleAspectFill
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        return tempImageView
    }()
    
    let desciptionLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.numberOfLines = 0
        tempLabel.textAlignment = .center
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    init(manager: DetailManager) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(imageView)
        self.view.addSubview(desciptionLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        
        self.title = self.manager.factItem.title
        if let imageUrlString = self.manager.factItem.imageHref, let url = URL(string: imageUrlString) {
            imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "image_not_available"))
        }
        desciptionLabel.text = self.manager.factItem.description
        setupConstraints()
    }
    
    func setupConstraints() {
        // setup imageView constraints
        self.view.removeConstraints(self.view.constraints)
        if UIDevice.current.orientation.isPortrait {
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: [], metrics: nil, views: ["imageView": imageView]))
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[desciptionLabel]|", options: [], metrics: nil, views: ["desciptionLabel": desciptionLabel]))
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView(==height@999)][desciptionLabel]|", options: [], metrics: ["height": self.manager.factItem.size?.height ?? defaultImageSize.height], views: ["imageView": imageView, "desciptionLabel": desciptionLabel]))

        } else {
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView(==width@999)][desciptionLabel]|", options: [], metrics: ["width": defaultImageSize.width], views: ["imageView": imageView, "desciptionLabel": desciptionLabel]))
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: [], metrics: nil, views: ["imageView": imageView]))
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[desciptionLabel]|", options: [], metrics: nil, views: ["desciptionLabel": desciptionLabel]))

        }
        self.view.layoutSubviews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

