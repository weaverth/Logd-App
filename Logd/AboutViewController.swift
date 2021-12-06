//
//  AboutViewController.swift
//  Logd
//
//  Created by Teddy Weaver on 12/6/21.
//

import UIKit
import AVFoundation

class AboutViewController: UIViewController {

    @IBOutlet weak var tedImage: UIImageView!
    var tedZoom: Bool = false
    
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
        tedZoom = true

    }

    @IBAction func kowabungaButtonPressed(_ sender: UIButton) {
        if tedZoom == true {
            tedImage.zoomIn()
            tedZoom = false
            playSound(name: "scream")
        }else {
            tedImage.zoomOut()
            tedZoom = true
            audioPlayer.stop()
        }
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIView {
    
    func zoomOut(duration: TimeInterval = 0.2){
        DispatchQueue.main.async{[weak self] in
            UIView.animate(withDuration: 0.3, animations: {[weak self] in
                self?.transform = .identity
            })
        }
    }
    func zoomIn(duration: TimeInterval = 0.2) {
        DispatchQueue.main.async{[weak self] in
                UIView.animate(withDuration: duration, animations: {[weak self] in
                    self?.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
                })
            }
    }
}
