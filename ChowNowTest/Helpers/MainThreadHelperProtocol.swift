//
//  MainThreadHelperProtocol.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit

typealias Block = () -> Void

protocol MainThreadHelperProtocol {
    func executeOnMainThread(block: @escaping Block)
}
