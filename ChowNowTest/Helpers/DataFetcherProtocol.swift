//
//  DataManager.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import Foundation

protocol DataFetcherProtocol {
    func fetch(url: URL, completion: @escaping (_ result: Data?, _ error: String?) -> Void)
}
