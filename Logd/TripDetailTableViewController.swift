//
//  TripDetailTableViewController.swift
//  Logd
//
//  Created by Teddy Weaver on 12/3/21.
//

import UIKit
import MapKit
import GooglePlaces


class TripDetailTableViewController: UITableViewController, MKMapViewDelegate {
    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var hikeButton: UIButton!
    @IBOutlet weak var bikeButton: UIButton!
    @IBOutlet weak var kayakButton: UIButton!
    @IBOutlet weak var climbButton: UIButton!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tripTypeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationNameLabel:
        UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    var trip: Trip!
    
    let regionDistance: CLLocationDegrees = 750.0
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide keyboard if we tap outside of a field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        if trip == nil {
            trip = Trip()
        }
        mapView.delegate = self
        setupMapView()
        updateUserInterface()
    }
    
    func setupMapView(){
        let tempCoordinate = CLLocationCoordinate2D(latitude: trip.coordinate.latitude, longitude: trip.coordinate.longitude)
        let region = MKCoordinateRegion(center: tempCoordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(region, animated: true)
        updateMap()
    }
    
    func updateMap(){
        let tempCoordinate = CLLocationCoordinate2D(latitude: trip.coordinate.latitude, longitude: trip.coordinate.longitude)
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = tempCoordinate
        annotation.title = trip.locationName
        annotation.subtitle = trip.tripType
        mapView.addAnnotation(annotation)
        mapView.setCenter(tempCoordinate, animated: true)
    }
    
    func updateUserInterface(){
        tripNameTextField.text = trip.tripName
        datePicker.date = trip.tripDate
        tripTypeLabel.text = trip.tripType
        locationNameLabel.text = trip.locationName
        notesTextView.text = trip.notes
        updateImageButtons()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        trip.tripName = tripNameTextField.text!
        trip.tripDate = datePicker.date
        trip.notes = notesTextView.text
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateImageButtons(){
        if trip.tripType == "hike"{
            hikeButton.setImage(UIImage(named: "hikeBeige"), for: .normal)
            bikeButton.setImage(UIImage(named: "bikeGreen"), for: .normal)
            kayakButton.setImage(UIImage(named: "kayakGreen"), for: .normal)
            climbButton.setImage(UIImage(named: "climbGreen"), for: .normal)
        }
        else if trip.tripType == "bike"{
            hikeButton.setImage(UIImage(named: "hikeGreen"), for: .normal)
            bikeButton.setImage(UIImage(named: "bikeBeige"), for: .normal)
            kayakButton.setImage(UIImage(named: "kayakGreen"), for: .normal)
            climbButton.setImage(UIImage(named: "climbGreen"), for: .normal)
        }
        else if trip.tripType == "kayak"{
            hikeButton.setImage(UIImage(named: "hikeGreen"), for: .normal)
            bikeButton.setImage(UIImage(named: "bikeGreen"), for: .normal)
            kayakButton.setImage(UIImage(named: "kayakBeige"), for: .normal)
            climbButton.setImage(UIImage(named: "climbGreen"), for: .normal)
        }
        else if trip.tripType == "climb"{
            hikeButton.setImage(UIImage(named: "hikeGreen"), for: .normal)
            bikeButton.setImage(UIImage(named: "bikeGreen"), for: .normal)
            kayakButton.setImage(UIImage(named: "kayakGreen"), for: .normal)
            climbButton.setImage(UIImage(named: "climbBeige"), for: .normal)
        }
        else {
            hikeButton.setImage(UIImage(named: "hikeGreen"), for: .normal)
            bikeButton.setImage(UIImage(named: "bikeGreen"), for: .normal)
            kayakButton.setImage(UIImage(named: "kayakGreen"), for: .normal)
            climbButton.setImage(UIImage(named: "climbGreen"), for: .normal)
        }
    }
    
    @IBAction func typeButtonPressed(_ sender: UIButton) {
        if sender.tag == 0{
            hikeButton.setImage(UIImage(named: "hikeBeige"), for: .normal)
            bikeButton.setImage(UIImage(named: "bikeGreen"), for: .normal)
            kayakButton.setImage(UIImage(named: "kayakGreen"), for: .normal)
            climbButton.setImage(UIImage(named: "climbGreen"), for: .normal)
            trip.tripType = "hike"
        }
        else if sender.tag == 1{
            hikeButton.setImage(UIImage(named: "hikeGreen"), for: .normal)
            bikeButton.setImage(UIImage(named: "bikeBeige"), for: .normal)
            kayakButton.setImage(UIImage(named: "kayakGreen"), for: .normal)
            climbButton.setImage(UIImage(named: "climbGreen"), for: .normal)
            trip.tripType = "bike"
            
        }
        else if sender.tag == 2{
            hikeButton.setImage(UIImage(named: "hikeGreen"), for: .normal)
            bikeButton.setImage(UIImage(named: "bikeGreen"), for: .normal)
            kayakButton.setImage(UIImage(named: "kayakBeige"), for: .normal)
            climbButton.setImage(UIImage(named: "climbGreen"), for: .normal)
            trip.tripType = "kayak"
        }
        else{
            hikeButton.setImage(UIImage(named: "hikeGreen"), for: .normal)
            bikeButton.setImage(UIImage(named: "bikeGreen"), for: .normal)
            kayakButton.setImage(UIImage(named: "kayakGreen"), for: .normal)
            climbButton.setImage(UIImage(named: "climbBeige"), for: .normal)
            trip.tripType = "climb"
        }
        tripTypeLabel.text = trip.tripType
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func nameFieldChanged(_ sender: UITextField) {
        trip.tripName = tripNameTextField.text!
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let brownColor = UIColor(named: "LogBrown")
        let greenColor = UIColor(named: "LogGreen")
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView

        header.textLabel?.textColor = greenColor
        header.textLabel?.font = UIFont(name: "Rockwell Bold", size: 14)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = NSTextAlignment.left
        header.textLabel?.text = header.textLabel!.text!.capitalized
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
}

extension TripDetailTableViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    trip.locationName = place.name ?? "Unknown Place"
    trip.address = place.formattedAddress ?? "Unknown Place"
    trip.coordinate.latitude = place.coordinate.latitude
    trip.coordinate.longitude = place.coordinate.longitude
    print("Coordinates = \(place.coordinate)")
    print("Trip latitude: \(trip.coordinate.latitude)")
    print("Trip longitude: \(trip.coordinate.longitude)")
    updateUserInterface()
    updateMap()
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}
