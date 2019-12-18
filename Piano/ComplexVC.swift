//
//  ComplexVC.swift
//  Piano
//
//  Created by Neil Sood on 12/17/19.
//  Copyright © 2019 Neil Sood. All rights reserved.
//

import UIKit
import AVFoundation

class ComplexVC: UIViewController {
    
    // MARK: outlets
    @IBOutlet var keysCollection: [UIButton]!
    
    
    // MARK: variables
    var player: AVAudioPlayer?
    
    // MARK: overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in keysCollection {
            initButtons(button: button)
        }
                
        // swipe gesture recognizer setup
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
//        swipeLeft.direction = .left
//        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true;
    }
    
    
    // MARK: actions
    @IBAction func keyPressed(_ sender: UIButton) {
        print(sender.tag)
        if sender.tag < 15 {
                UIView.animate(withDuration: 0.1, animations: {
                    sender.backgroundColor = .black
        //            sender.titleLabel?.textColor = .white
                }, completion: { _ in
                    sender.backgroundColor = .white
        //            sender.titleLabel?.textColor = .black
                })
            }
            else {
                UIView.animate(withDuration: 0.1, animations: {
                    sender.backgroundColor = .white
                }, completion: { _ in
                    sender.backgroundColor = .black
                })
            }
            playSound(num: sender.tag)
    }
    

    // MARK: functions
    
    func initButtons(button: UIButton) {
//        button.titleLabel?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        button.titleLabel?.textAlignment = .center
//        button.titleLabel?.numberOfLines = 1
        if button.tag < 15 {
            button.contentEdgeInsets = UIEdgeInsets(top: 0,left: 20,bottom: 0,right: 0)
        }
        else {
            button.contentEdgeInsets = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 0)
        }
    }
    
    func playSound(num: Int) {
        print(num)
        let octave: String = "3"
        var chord: String = ""
        let octavePlus = String(Int(octave)! + 1)
        switch num {
        case 1: chord = "C" + octave
        case 15: chord = "Db" + octave
        case 2: chord = "D" + octave
        case 16: chord = "Eb" + octave
        case 3: chord = "E" + octave
        case 4: chord = "F" + octave
        case 17: chord = "Gb" + octave
        case 5: chord = "G" + octave
        case 18: chord = "Ab" + octave
        case 6: chord = "A" + octave
        case 19: chord = "Bb" + octave
        case 7: chord = "B" + octave
        case 8: chord = "C" + octavePlus
        case 20: chord = "Db" + octavePlus
        case 9: chord = "D" + octavePlus
        case 21: chord = "Eb" + octavePlus
        case 10: chord = "E" + octavePlus
        case 11: chord = "F" + octavePlus
        case 22: chord = "Gb" + octavePlus
        case 12: chord = "G" + octavePlus
        case 23: chord = "Ab" + octavePlus
        case 13: chord = "A" + octavePlus
        case 24: chord = "Bb" + octavePlus
        case 14: chord = "B" + octavePlus
        default: print("error with chords")
        }
        let sound = "Piano.ff." + chord
        guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else {
            print("url not found")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }
            player.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                player.stop()
            }
        } catch let error {
            print(error.localizedDescription)
        }

    }
    // swipe gesture recognizer handler
//    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
//        if gesture.direction == .left {
//            print("Swipe Left")
//            dismiss(animated: true, completion: nil)
//        }
//    }
   

}
