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

class SearchDogsMapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var annotation: MapAnnotation?
    var viewModel: SearchDogsMapViewModel = SearchDogsMapViewModel(api: DogFinderApi.sharedInstance)
    var oldAnnatiations: [MKAnnotation] = [MKAnnotation]()
    var newAnnatiations: [MKAnnotation] = [MKAnnotation]()

    override func viewDidLoad() {

        self.viewModel.initLocationManager()
    }

    override func viewWillAppear(_ animated: Bool) {

        self.goToMyLocation()
        self.viewModel.downloadNextNearestSpottedDogsOnMap {
            self.addDogsToMap()
        }
    }

    private func goToMyLocation() {

        guard let lastLoc = self.viewModel.lastLocation else {
//            self.enableLocationAlert()
            return
        }
        let zoomLocation = CLLocationCoordinate2D(latitude: lastLoc.coordinate.latitude, longitude: lastLoc.coordinate.longitude)

        let viewRegion = MKCoordinateRegion(center: zoomLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)

        self.mapView.setRegion(viewRegion, animated: true)
    }

    private func downloadDogsForSelectedCategory() {
        if self.viewModel.areSpotted {
            self.viewModel.downloadNextNearestSpottedDogsOnMap {
                self.addDogsToMap()
            }
        } else {
            self.viewModel.downloadNextNearestMissingDogsOnMap {
                self.addDogsToMap()
            }
        }
    }

    private func presentDogDetails(dog: Dog) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DogDetailsViewController") as! DogDetailsViewController
        vc.initViewModel(dog: dog)

        self.navigationController?.show(vc, sender: nil)
    }

    private func addDogsToMap() {
        for dog in self.viewModel.dogs {
            let annatation = MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: dog.latitude)!, longitude: CLLocationDegrees(dog.longitude)))
            annatation.title = dog.breed
            annatation.subtitle = "Last seen: \(dog.seenDate)"
            annatation.image = dog.photoName
            annatation.dog = dog
            self.newAnnatiations.append(annatation)
        }
        self.mapView.removeAnnotations(self.oldAnnatiations)
        self.mapView.addAnnotations(self.newAnnatiations)
        self.oldAnnatiations = self.newAnnatiations
    }

    func showSpotted() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.viewModel.showSpotted {
            self.addDogsToMap()
        }
    }

    func showMissing() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.viewModel.showMissing {
            self.addDogsToMap()
        }
    }
}

extension SearchDogsMapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        manager.stopUpdatingLocation()
        self.viewModel.lastLocation = locations.last
//        self.lastLocation = location

        let zoomLocation = CLLocationCoordinate2D(latitude: (self.viewModel.lastLocation?.coordinate.latitude)!, longitude: (self.viewModel.lastLocation?.coordinate.longitude)!)

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

        let center = mapView.centerCoordinate
        let radius = mapView.radius
        self.viewModel.set(center, radius)
        self.oldAnnatiations = self.newAnnatiations
        self.newAnnatiations = [MKAnnotation]()
        self.downloadDogsForSelectedCategory()

    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        let annatation = view.annotation as? MapAnnotation
        if let dog = annatation?.dog {
            self.presentDogDetails(dog: dog)
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
}
