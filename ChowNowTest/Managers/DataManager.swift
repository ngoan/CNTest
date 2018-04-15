//
//  DataManager.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit
import CoreLocation

class DataManager: DataManagerProtocol {
    
    static private let apiCompanyURL = "https://api.chownow.com/api/company/1"
    var dataFetcher: DataFetcherProtocol = DataFetcher()
    var threadHelper: MainThreadHelperProtocol = MainThreadHelper()
    
    func fetchRestaurant(completion: @escaping (_ result: CNRestaurant?, _ error: String?) -> Void) {
        guard let url = URL(string: DataManager.apiCompanyURL) else {
            fatalError("invalid URL")
        }
        dataFetcher.fetch(url: url) { [weak self] (data, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CNRestaurant.self, from: data)
                    self?.threadHelper.executeOnMainThread {
                        completion(result, nil)
                    }
                } catch let error as NSError {
                    self?.threadHelper.executeOnMainThread {
                        completion(nil, error.localizedDescription)
                    }
                }
            }
        }
    }
}
