//
//  MainThreadHelper.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit

class MainThreadHelper: MainThreadHelperProtocol {
    func executeOnMainThread(block: @escaping Block) {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                block()
            }
        } else {
            block()
        }
    }
}
