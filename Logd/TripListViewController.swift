//
//  ViewController.swift
//  Logd
//
//  Created by Teddy Weaver on 12/3/21.
//

import UIKit

class TripListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var trips = Trips()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        trips.loadData {
            self.tableView.reloadData()
        }
    }
    
    func saveData(){
        trips.saveData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! TripDetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.trip = trips.tripsArray[selectedIndexPath.row]
        }
        else if segue.identifier == "ShowMap" {
            let destination = segue.destination as! MapViewController
            destination.trips = trips.tripsArray
        }
        else { // when pressing add button
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! TripDetailTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            trips.tripsArray[selectedIndexPath.row] = source.trip
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
        else { // for adding a new trip
            let newIndexPath = IndexPath(row: trips.tripsArray.count, section: 0)
            trips.tripsArray.append(source.trip)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        saveData()
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarButton.isEnabled = true
        }
        else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBarButton.isEnabled = false
        }
    }
}

extension TripListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.tripsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TripTableViewCell
        cell.trip = trips.tripsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            trips.tripsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = trips.tripsArray[sourceIndexPath.row]
        trips.tripsArray.remove(at: sourceIndexPath.row)
        trips.tripsArray.insert(itemToMove, at: destinationIndexPath.row)
        saveData()
    }
    
}
