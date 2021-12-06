//
//  MapViewController.swift
//  Logd
//
//  Created by Teddy Weaver on 11/25/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapZoomButton: UIButton!
    
    
    var trips: [Trip] = []
    var coordinateList: [CLLocationCoordinate2D] = []
    var currentCoordinateIndex = 0
    var zoomButtonToggle = true
    
    func getCoordinateList(){
        for trip in trips{
            let tempCoordinate = CLLocationCoordinate2D(latitude: trip.coordinate.latitude, longitude: trip.coordinate.longitude)
            coordinateList.append(tempCoordinate)
        }
    }
    
    func getCenterPoint() -> CLLocationCoordinate2D {
        var latitudeList: [Double] = []
        var longitudeList: [Double] = []
        // populating latitudes and longitudes
        for coordinate in coordinateList {
            latitudeList.append(coordinate.latitude)
            longitudeList.append(coordinate.longitude)
        }
        var latSum = 0.0
        var longSum = 0.0
        for latitude in latitudeList{
            latSum += latitude
        }
        for longitude in longitudeList{
            longSum += longitude
        }
        let averageLat = (latSum / Double(latitudeList.count))
        let averageLong = (longSum / Double(longitudeList.count))
        let centerPoint = CLLocationCoordinate2D(latitude: averageLat, longitude: averageLong)
        return centerPoint
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCoordinateList()
        mapView.delegate = self
        self.configureMap()
        self.placePins()
    }

    func configureMap() {
        let center = getCenterPoint()
        let span = MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }

    func placePins() {
        for i in coordinateList.indices {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinateList[i]
            annotation.title = trips[i].tripName
            annotation.subtitle = trips[i].tripType
            mapView.addAnnotation(annotation)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let brownColor = UIColor(named: "LogBrown")
        let greenColor = UIColor(named: "LogGreen")
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
        annotationView.glyphTintColor = UIColor.black
        switch annotation.subtitle!! {
            case "hike":
                annotationView.markerTintColor = greenColor
                annotationView.glyphImage = UIImage(named: "hikeGlyph")
            case "bike":
                annotationView.markerTintColor = greenColor
                annotationView.glyphImage = UIImage(named: "bikeGlyph")
            case "kayak":
                annotationView.markerTintColor = greenColor
                annotationView.glyphImage = UIImage(named: "kayakGlyph")
            case "climb":
                annotationView.markerTintColor = greenColor
                annotationView.glyphImage = UIImage(named: "climbGlyph")
            default:
                annotationView.markerTintColor = brownColor
        }
        return annotationView
    }
    
    @IBAction func zoomButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            if zoomButtonToggle == true{
                let center = coordinateList[currentCoordinateIndex]
                let span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
                let region = MKCoordinateRegion(center: center, span: span)
                mapView.setRegion(region, animated: true)
                zoomButtonToggle = false
                mapZoomButton.setTitle("Center", for: .normal)
            }else{
                configureMap()
                zoomButtonToggle = true
                mapZoomButton.setTitle("Zoom to Trip", for: .normal)
            }
        }
        else {
            let increment = sender.tag
            currentCoordinateIndex = currentCoordinateIndex + increment
            if currentCoordinateIndex < 0{
                currentCoordinateIndex = coordinateList.count - 1
            }
            else if currentCoordinateIndex > coordinateList.count - 1{
                currentCoordinateIndex = 0
            }
            let center = coordinateList[currentCoordinateIndex]
            let span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.setRegion(region, animated: true)
            zoomButtonToggle = false
            mapZoomButton.setTitle("Center", for: .normal)
        }
        
    }
}
