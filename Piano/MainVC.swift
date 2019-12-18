//
//  MainVC.swift
//  Piano
//
//  Created by Neil Sood on 12/16/19.
//  Copyright © 2019 Neil Sood. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController {
    
// MARK: outlets
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var secondaryButtonCollection: [UIButton]!
    
    @IBOutlet weak var mainKeyWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainStackView: UIStackView!
    
    // MARK: variables
    var player: AVAudioPlayer?
    
// MARK: overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in buttonCollection {
            initButtons(button: button)
        }
        for button in secondaryButtonCollection {
            initButtons(button: button)
        }
        
        mainStackView.frame.size.width = self.view.frame.width
        
//        mainKeyWidthConstraint.constant = self.view.frame.width-50
        self.view.sendSubviewToBack(mainStackView)
        
        // swipe gesture recognizer setup
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true;
    }
    
// MARK: actions
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.tag < 9 {
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
        button.titleLabel?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 1
        button.contentEdgeInsets = UIEdgeInsets(top: 0,left: 20,bottom: 0,right: 0)
    }

    func playSound(num: Int) {
        print(num)
        let octave: String = "3"
        var chord: String = ""
        let octavePlus = String(Int(octave)! + 1)
        switch num {
        case 1: chord = "C" + octave
        case 2: chord = "D" + octave
        case 3: chord = "E" + octave
        case 4: chord = "F" + octave
        case 5: chord = "G" + octave
        case 6: chord = "A" + octave
        case 7: chord = "B" + octave
        case 8: chord = "C" + octavePlus
        case 9: chord = "Db" + octave
        case 10: chord = "Eb" + octave
        case 11: chord = "Gb" + octave
        case 12: chord = "Ab" + octave
        case 13: chord = "Bb" + octave
        case 14: chord = "Db" + octavePlus
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
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            performSegue(withIdentifier: "ToComplexSegue", sender: self)
        }
    }
}

// MARK: extensions
 
