//
//  BaseViewController.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem(image: UIImage(named: "back"),
                                       style: .done,
                                       target: self,
                                       action: #selector(backItemPressed))
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    @objc func backItemPressed() {
        navigationController?.popViewController(animated: true)
    }
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.cn_squidInk(),
             NSAttributedStringKey.font: UIFont.cn_mediumFont(size: 18)]
        navigationController?.navigationBar.tintColor = UIColor.cn_squidInk()
        navigationController?.navigationBar.backgroundColor = .white
        
        let backItem = UIBarButtonItem(image: UIImage(named: "back"),
                                       style: .done,
                                       target: self,
                                       action: #selector(backItemPressed))
        if !navigationItem.hidesBackButton {
            self.navigationItem.leftBarButtonItem = backItem
        }
    }
    
    @objc func backItemPressed() {
        navigationController?.popViewController(animated: true)
    }
}
