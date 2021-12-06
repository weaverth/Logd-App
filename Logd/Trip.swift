//
//  Trip.swift
//  Logd
//
//  Created by Teddy Weaver on 11/25/21.
//

import Foundation
import MapKit

class Trip: Codable {
    
   
    var tripName: String
    var tripDate: Date
    var tripType: String
    var locationName: String
    var address: String
    var coordinate: Coordinate
    var notes: String
    
    struct Coordinate: Codable {
        var latitude: Double
        var longitude: Double
    }
    
    internal init(tripName: String, tripDate: Date, tripType: String, locationName: String, address: String, coordinate: Coordinate, notes: String) {
        self.tripName = tripName
        self.tripDate = tripDate
        self.tripType = tripType
        self.locationName = locationName
        self.address = address
        self.coordinate = coordinate
        self.notes = notes
    }
    
    convenience init() {
        self.init(tripName: "", tripDate: Date(), tripType: "hike", locationName: "", address: "", coordinate: Coordinate(latitude: 0.0, longitude: 0.0), notes: "")
    }
}
