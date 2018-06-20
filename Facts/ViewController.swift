//
//  ViewController.swift
//  Facts
//
//  Created by Hanuman on 20/06/18.
//  Copyright © 2018 Hanuman. All rights reserved.
//

import UIKit
import MBProgressHUD
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView?
    
    let defaultItemSize = CGSize(width: 50, height: 50)
    
    let refreshControl: UIRefreshControl = {
        let tempRefreshControl = UIRefreshControl()
        tempRefreshControl.attributedTitle = NSAttributedString(string:"Pull to refresh")
        tempRefreshControl.addTarget(self, action: #selector(ViewController.reloadView), for: UIControlEvents.valueChanged)
        return tempRefreshControl
    }()

    let manager = ViewManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        collectionView?.addSubview(refreshControl)
        
        reloadView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.manager.factsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let factItem = self.manager.getFactItem(representedByRowNumber: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FactItemCollectionViewCell.identifier, for: indexPath) as! FactItemCollectionViewCell

        cell.imageView?.image = #imageLiteral(resourceName: "image_not_available")
        if let imageUrlString = factItem?.imageHref, let url = URL(string: imageUrlString) {
            cell.imageView?.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "image_not_available"), completionHandler: { (image, error, cache, url) in
                let maxWidth = min(image?.size.width ?? self.defaultItemSize.width, collectionView.bounds.size.width)
                factItem?.size = CGSize(width: maxWidth, height: image?.size.height ?? self.defaultItemSize.height)
                self.collectionView?.collectionViewLayout.invalidateLayout()
            })
        }
        cell.titleLabel?.text = factItem?.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let factItem = self.manager.getFactItem(representedByRowNumber: indexPath.row)
        return factItem?.size ?? defaultItemSize
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let factItem = self.manager.getFactItem(representedByRowNumber: indexPath.row) else {
            return
        }
        let detailManager = DetailManager(facItem: factItem)
        let detailVC = DetailViewController(manager: detailManager)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController {
    @objc
    func reloadView(){
        refreshControl.beginRefreshing()
        manager.fetchFacts { (error) in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.title = self.manager.getCountryTitle()
                self.displayErrorAlert(error)
                self.collectionView?.reloadData()
            }
        }
    }
}

extension UIViewController {
    func displayErrorAlert(_ error: Error?) {
        if let error = error {
            let alertController = UIAlertController(title: NSLocalizedString("Oops!", comment: "generic Error title"), message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok confirmation"), style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
