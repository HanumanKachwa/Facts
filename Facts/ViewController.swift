//
//  ViewController.swift
//  Facts
//
//  Created by Hanuman on 20/06/18.
//  Copyright © 2018 Hanuman. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        MBProgressHUD.showAdded(to: self.view, animated: true)
        CountryFactsAPI.getFacts { [weak self] (facts, error) in
            guard let weakSelf = self else {
                return
            }
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: weakSelf.view, animated: true)
                weakSelf.displayErrorAlert(error)
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
