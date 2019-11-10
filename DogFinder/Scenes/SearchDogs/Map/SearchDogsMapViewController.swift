//
//  SearchDogsMapViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 21/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

class SearchDogsMapViewController: UIViewController, CurrentLocationProtocol {

    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    var annotation: MapAnnotation?
    var viewModel: SearchDogsViewModel = SearchDogsViewModel(api: DogFinderApi.sharedInstance)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initLocationManager()
        self.goToMyLocation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.locationManager?.stopUpdatingLocation()
    }

    func goToMyLocation() {

        guard let lastLoc = self.lastLocation else {
//            self.enableLocationAlert()
            return
        }
        let zoomLocation = CLLocationCoordinate2D(latitude: lastLoc.coordinate.latitude, longitude: lastLoc.coordinate.longitude)

        let viewRegion = MKCoordinateRegion(center: zoomLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)

        self.mapView.setRegion(viewRegion, animated: true)
    }
}

extension SearchDogsMapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        manager.stopUpdatingLocation()
        let location = locations.last
        self.lastLocation = location

        let zoomLocation = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)

        let viewRegion = MKCoordinateRegion(center: zoomLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
        self.mapView.setRegion(viewRegion, animated: true)
    }
}

extension SearchDogsMapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        var annatationView = mapView.dequeueReusableAnnotationView(withIdentifier: "dog")

        if annatationView == nil {
            annatationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "dog")
        } else {
            annatationView?.annotation = annotation
        }

        if let mapAnnotation = annotation as? MapAnnotation {
                    annatationView?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)

                    if let annotationImage = mapAnnotation.image {

                        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                        let photo = DogFinderApi.sharedInstance.getUrlOfPhoto(photoName: annotationImage)
                        imageView.kf.setImage(with: photo)
                        imageView.layer.cornerRadius = imageView.layer.frame.size.width / 2
                        imageView.layer.masksToBounds = true
                        annatationView?.addSubview(imageView)
                    }
        }

        return annatationView
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        self.search()

//        self.viewModel.downloadNextDogs()
        for dog in self.viewModel.dogs {

            let annatation = MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: dog.latitude)!, longitude: CLLocationDegrees(dog.longitude)))
            annatation.title = dog.breed
            annatation.subtitle = "Last seen: \(dog.seenDate)"
            annatation.image = dog.photoName
            self.mapView.addAnnotation(annatation)

            //tmp
//            let zoomLocation = CLLocationCoordinate2D(latitude: (annatation.coordinate.latitude), longitude: (annatation.coordinate.longitude))
//            let viewRegion = MKCoordinateRegion(center: zoomLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
//            self.mapView.setRegion(viewRegion, animated: true)
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //        self.navigationItem.titleView?.endEditing(true)
//        self.destination = view.annotation?.coordinate
//        self.annotation = view.annotation as? MapAnnotation
//        self.showDetailsView()
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {

    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
}
