//
//  AlertHelper.swift
//  RingTest
//
//  Created by Ngoan Nguyen on 2/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit

class AlertHelper: AlertHelperProtocol {
    func showAlertWith(title: String, message: String, viewController: UIViewController) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
