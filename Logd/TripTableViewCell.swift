//
//  TripTableViewCell.swift
//  Logd
//
//  Created by Teddy Weaver on 12/5/21.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var symbolImageView: UIImageView!
    @IBOutlet weak var tripDateLabel: UILabel!
    
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, y"
        return dateFormatter
    }()
    
    
    var trip: Trip! {
        didSet {
            tripNameLabel.text = trip.tripName
            symbolImageView.image = UIImage(named: "\(trip.tripType)")
            let convertedDate = dateFormatter.string(from: trip.tripDate)
            tripDateLabel.text = convertedDate
        }
    }
    

}
