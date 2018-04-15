//
//  LocationsTableViewController.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

private enum SortOrder {
    case unsorted
    case descending
    case ascending
}

class LocationsTableViewController: BaseTableViewController {
    
    private let animationDuration = 0.30
    private let detailsTableViewSegueIdentifier = "DetailsTableViewSegueIdentifier"
    private let cellIdentifier = "LocationCellIdentifier"
    var locations: [CNLocation]?
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    private var sortOrder: SortOrder = .unsorted
    private var threadHelper = MainThreadHelper()
    private let alertHelper = AlertHelper()
    var mutatedLocations = [CNLocation]()
    var previousLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showSpinner(true)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        let deadlineTime = DispatchTime.now() + animationDuration
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            if let locations = self.locations {
                self.configureView(for: locations)
            }
            self.requestLocationAuthorization()
        }
    }
    
    private func showSpinner(_ show: Bool) {
        if show {
            let headerView = IndicatorHeaderView(frame: CGRect(origin: .zero, size: CGSize(width: tableView.frame.size.width, height: 44)))
            tableView.tableHeaderView = headerView
        } else {
            tableView.tableHeaderView = nil
        }
    }
    
    private func configureView(for locations: [CNLocation]) {
        self.navigationItem.title = "\(locations.count) Locations"
        var indexPaths = [IndexPath]()
        for (index, location) in locations.enumerated() {
            indexPaths.append(IndexPath(row: index, section: 0))
            mutatedLocations.append(location)
        }
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.tableHeaderView = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsTableViewSegueIdentifier {
            if let detailsViewController = segue.destination as? DetailsTableViewController {
                detailsViewController.location = sender as? CNLocation
            }
        }
    }
    
    @objc func sortItemPressed() {
        showSpinner(true)
        mutatedLocations.removeAll()
        tableView.reloadData()
        let deadlineTime = DispatchTime.now() + animationDuration
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            if let locations = self.locations {
                self.mutatedLocations = locations
                switch self.sortOrder {
                case .unsorted:
                    fallthrough
                case .descending:
                    self.sort(order: .ascending)
                case .ascending:
                    self.sort(order: .descending)
                }
                self.tableView.reloadData()
                self.showSpinner(false)
            }
        }
    }
    
    private func sort(order: SortOrder) {
        if order == .ascending {
            let sorted = mutatedLocations.sorted(by: { ( leftLocation, rightLocation ) -> Bool in
                return leftLocation.distance < rightLocation.distance
            })
            mutatedLocations = sorted
        } else {
            let sorted = mutatedLocations.sorted(by: { ( leftLocation, rightLocation ) -> Bool in
                return leftLocation.distance > rightLocation.distance
            })
            mutatedLocations = sorted
        }
        sortOrder = order
    }
    
    private func configureSortItem() {
        let sortItem = UIBarButtonItem(image: UIImage(named: "sort"),
                                       style: .done,
                                       target: self,
                                       action: #selector(sortItemPressed))
        navigationItem.setRightBarButton(sortItem, animated: true)
    }
    
    private func requestLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways:
                fallthrough
            case .authorizedWhenInUse:
                locationManager.requestLocation()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .denied:
                fallthrough
            case .restricted:
                alertHelper.showAlertWith(title: "Please allow location access if you would like to display appropriate distance information for nearby restaurants",
                                          message: "",
                                          viewController: self)
            }
        }
    }
    
    private func sortOrRequestLocation() {
        switch sortOrder {
        case .unsorted:
            locationManager.requestLocation()
        case .ascending:
            sort(order: .descending)
            tableView.reloadData()
        case .descending:
            sort(order: .ascending)
            tableView.reloadData()
        }
    }
}

extension LocationsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mutatedLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LocationTableViewCell else {
            fatalError("Could not get cell")
        }
        let location = mutatedLocations[indexPath.row]
        cell.location = location
        cell.distanceInMiles = location.distance
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailsTableViewSegueIdentifier, sender: mutatedLocations[indexPath.row])
    }
    
    private func updateDistances(with foundCoordinate: CLLocationCoordinate2D) {
        for restaurantLocation in mutatedLocations {
            if let restaurantCoordinate = restaurantLocation.address.coordinates() {
                let restaurantPoint = MKMapPointForCoordinate(restaurantCoordinate)
                let foundPoint = MKMapPointForCoordinate(foundCoordinate)
                let distance = MKMetersBetweenMapPoints(restaurantPoint, foundPoint)
                restaurantLocation.distance = distance
            }
        }
    }
    
    private func updateView(for location: CLLocation) {
        previousLocation = location
        updateDistances(with: location.coordinate)
        configureSortItem()
        self.tableView.reloadData()
    }
}

extension LocationsTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .denied {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let foundLocation = locations.first else {
            return
        }
        
        guard let previousLocation = previousLocation else {
            threadHelper.executeOnMainThread {
                self.updateView(for: foundLocation)
            }
            return
        }
        
        if (foundLocation.timestamp.timeIntervalSince1970 -
            previousLocation.timestamp.timeIntervalSince1970) >= 30 {
            threadHelper.executeOnMainThread {
                self.updateView(for: foundLocation)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
