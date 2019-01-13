//
//  MapVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/11/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    //vars
    let marker = GMSMarker()
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var latitude = UserDefaults.standard.string(forKey: "latitude") ?? ""
    var longitude = UserDefaults.standard.string(forKey: "longitude") ?? ""
    
    
    @IBAction func selectorderlocation(_ sender: Any) {
        performSegue(withIdentifier: "sg_toOrderCost", sender: self)
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "orderCost") as! OrderCostVC
//        newViewController.hidesBottomBarWhenPushed = false
//        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func setupNavigationBarStyle(){
        //change navigation color and tab bar text color
//        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 122, blue: 255 ,alpha : 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        self.title = "Cruise"
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .top
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(latitude)!, longitude: Double(longitude)!, zoom: 6.0)
        mapView.camera = camera
        //show MyLocation Button to bottom of screen
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        showMarker(position: camera.target)
        
        //for autocomplete placeapi
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        
        let subView = UIView(frame: CGRect(x: 0, y: 65.0, width: 350.0, height: 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
    }
    
    func gotoMyLocationAction(sender: UIButton)
    {
        guard let lat = self.mapView.myLocation?.coordinate.latitude,
            let lng = self.mapView.myLocation?.coordinate.longitude else { return }
        
        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 6.0)
        self.mapView.animate(to: camera)
    }
    
    func showMarker(position: CLLocationCoordinate2D){
        marker.position = position
        marker.title = "Palo Alto"
        marker.snippet = "San Francisco"
        marker.isDraggable = true
        marker.map = mapView
    }

}

extension MapVC : GMSMapViewDelegate , GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("place")
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        latitude = String(place.coordinate.latitude)
        longitude = String(place.coordinate.longitude)
    
        guard let lat = self.mapView.myLocation?.coordinate.latitude,
            let lng = self.mapView.myLocation?.coordinate.longitude else { return }
        
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude ,longitude: place.coordinate.longitude , zoom: 6.0)
        self.mapView.animate(to: camera)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
    //returns the coordinate from the tapped area on the map
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        marker.position = coordinate
    }
    //MARK - GMSMarker Dragging
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("didBeginDragging")
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("didDrag")
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("didEndDragging")
    }
}
