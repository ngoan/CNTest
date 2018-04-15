//
//  DataManager.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class DataFetcher: DataFetcherProtocol {
    func fetch(url: URL, completion: @escaping (_ result: Data?, _ error: String?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)    
        let urlRequest = URLRequest(url: url)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                return completion(nil, "Invalid response")
            }
            completion(data, error?.localizedDescription)
        }
        task.resume()
    }
}
