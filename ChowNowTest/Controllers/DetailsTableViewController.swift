//
//  DetailsTableViewController.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit
import MapKit

class DetailsTableViewController: BaseTableViewController {
    
    @IBOutlet var mapView: MKMapView?
    @IBOutlet var detailsCell: UITableViewCell?
    @IBOutlet var phoneCell: UITableViewCell?
    
    var location: CNLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = location?.shortName
        
        tableView.tableFooterView = UIView()
        
        detailsCell?.textLabel?.text = location?.name
        detailsCell?.textLabel?.font = UIFont.cn_mediumFont(size: 18.0)
        detailsCell?.detailTextLabel?.text = location?.address.formattedAddress
        detailsCell?.detailTextLabel?.font = UIFont.cn_normalFont(size: 14)
        
        detailsCell?.textLabel?.textColor = UIColor.cn_gojiBerry()
        detailsCell?.detailTextLabel?.textColor = UIColor.cn_squidInk()
        
        phoneCell?.textLabel?.font = UIFont.cn_normalFont(size: 14)
        phoneCell?.textLabel?.textColor = UIColor.cn_squidInk()
        phoneCell?.textLabel?.text = "Telephone"
        phoneCell?.detailTextLabel?.text = location?.phone
        phoneCell?.detailTextLabel?.font = UIFont.cn_normalFont(size: 14)
        phoneCell?.detailTextLabel?.textColor = UIColor.cn_squidInk()
        
        if let location = location, let coordinates = location.address.coordinates(), let mapView = mapView {
            let region = MKCoordinateRegionMakeWithDistance(coordinates, 250, 250)
            mapView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = location.shortName
            mapView.addAnnotation(annotation)
        }
    }
    
    private func presentDetailsAction() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = UIColor.cn_squidInk()
        let copyAction = UIAlertAction(title: "Copy Address", style: .default) { [weak self] ( action ) in
            if let location = self?.location?.address.placeFormattedAddress {
                UIPasteboard.general.string = location
            }
        }
        let directionsAction = UIAlertAction(title: "Driving Directions", style: .default) { [weak self]  ( action ) in
            if let coordinates = self?.location?.address.coordinates() {
                let placeMark = MKPlacemark(coordinate: coordinates)
                let mapItem = MKMapItem(placemark: placeMark)
                mapItem.openInMaps(launchOptions:
                    [MKLaunchOptionsDirectionsModeKey:
                        MKLaunchOptionsDirectionsModeDriving])
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(copyAction)
        alertController.addAction(directionsAction)
        alertController.addAction(cancelAction)
        presentAlertController(alertController, detailsCell)
    }
    
    private func presentPhoneAction() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = UIColor.cn_squidInk()
        let callAction = UIAlertAction(title: "Call Business", style: .default) { [weak self] ( action ) in
            if let location = self?.location, let phoneURL = URL(string: "tel://" + location.phone) {
                if UIApplication.shared.canOpenURL(phoneURL) {
                    UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(callAction)
        alertController.addAction(cancelAction)
        presentAlertController(alertController, phoneCell)
    }
    
    private func presentAlertController(_ alertController: UIAlertController, _ cell: UITableViewCell?) {
        if let popoverController = alertController.popoverPresentationController, let cell = cell {
            popoverController.sourceView = view
            popoverController.sourceRect = CGRect(origin: CGPoint(x: cell.bounds.midX,
                                                                  y: cell.frame.minY),
                                                  size: .zero)
            popoverController.permittedArrowDirections = .down
        }
        present(alertController, animated: true, completion: nil)
    }
}

extension DetailsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell == detailsCell {
            presentDetailsAction()
        } else if cell == phoneCell {
            presentPhoneAction()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
