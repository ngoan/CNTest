//
//  RestaurantAddress.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit
import CoreLocation

struct CNAddress: Codable {
    let formattedAddress: String
    let geo: String
    let placeFormattedAddress: String
    let identifier: Int
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case geo
        case placeFormattedAddress = "place_formatted_address"
        case identifier = "id"
    }
    
    func coordinates() -> CLLocationCoordinate2D? {
        let geoArray: [String] = geo.components(separatedBy: ",")
        if geoArray.count == 2 {
            if let first = geoArray.first, let second = geoArray.last, let firstDouble = Double(first), let secondDouble = Double(second) {
                return CLLocationCoordinate2D(latitude: firstDouble, longitude: secondDouble)
            }
        }
        return nil
    }
}
