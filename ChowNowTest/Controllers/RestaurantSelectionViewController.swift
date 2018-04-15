//
//  ViewController.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit

class RestaurantSelectionViewController: BaseViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView?
    private let restaurantSelectionCellIdentifier: String = "RestaurantSelectionCellIdentifier"
    private let locationsTableViewSegueIdentifier: String = "LocationsTableViewSegueIdentifier"
    private let cellSize = CGSize(width: 300, height: 300)
    private var dataManager  = DataManager()
    private var restaurants = [CNRestaurant]()
    private var alertHelper = AlertHelper()
    private var refreshControl: UIRefreshControl!
    private var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "Restaurants"
        configureViews()
    }
    
    private func configureViews() {
        indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.color = UIColor.cn_squidInk()
        indicatorView.hidesWhenStopped = true
        indicatorView.startAnimating()
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.cn_squidInk()
        refreshControl.addTarget(self, action: #selector(didTriggerRefresh), for: .valueChanged)
        refreshControl.beginRefreshing()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        if let collectionView = collectionView {
            collectionView.addSubview(indicatorView)
            collectionView.addConstraints([NSLayoutConstraint(item: collectionView, attribute: .centerX,
                                                              relatedBy: .equal, toItem: indicatorView,
                                                              attribute: .centerX, multiplier: 1.0,
                                                              constant: 0),
                                           NSLayoutConstraint(item: collectionView, attribute: .centerY,
                                                              relatedBy: .equal, toItem: indicatorView,
                                                              attribute: .centerY, multiplier: 1.0,
                                                              constant: 0)])
            collectionView.collectionViewLayout = flowLayout
            collectionView.addSubview(refreshControl)
            fetchRestaurants()
        }
    }
    
    @objc func didTriggerRefresh() {
        fetchRestaurants()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == locationsTableViewSegueIdentifier {
            let controller = segue.destination as? LocationsTableViewController
            controller?.locations = sender as? [CNLocation]
        }
    }
    
    private func fetchRestaurants() {
        dataManager.fetchRestaurant { [weak self] (restaurant, error) in
            if let error = error {
                self?.alertHelper.showAlertWith(title: "Error", message: error, viewController: self!)
                self?.collectionView?.reloadData()
                self?.indicatorView.stopAnimating()
                self?.refreshControl.endRefreshing()
                return
            }
            
            if let restaurant = restaurant {
                self?.restaurants = [restaurant]
            }
            self?.collectionView?.reloadData()
            self?.refreshControl.endRefreshing()
            self?.indicatorView.stopAnimating()
        }
    }
}

extension RestaurantSelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: cellSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let restaurant: CNRestaurant = self.restaurants[indexPath.item]
        performSegue(withIdentifier: locationsTableViewSegueIdentifier, sender: restaurant.locations)
    }
}

extension RestaurantSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantSelectionCellIdentifier, for: indexPath) as? RestaurantSelectionCell else {
            fatalError("Unable to get cell")
        }
        cell.restaurant = restaurants[indexPath.item]
        return cell
    }
}
