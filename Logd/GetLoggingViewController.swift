//
//  GetLoggingViewController.swift
//  Logd
//
//  Created by Teddy Weaver on 11/26/21.
//

import UIKit
import AVFoundation

class GetLoggingViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    func playSound(name: String){
        if let sound = NSDataAsset(name: name){
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound(name: "nature")

    }

    @IBAction func getLoggingPressed(_ sender: UIButton) {
        playSound(name: "logSound")
        performSegue(withIdentifier: "GetLoggingSegue", sender: nil)
    }
    
}
