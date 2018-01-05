//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Vineet Joshi on 1/3/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

// In order to create this file:
//      Make sure the Pitch Perfect yellow folder is selected, then Command+N to create new file
//      Choose Cocoa Touch Class, and make it a subclass of UIViewController
// Then go to storyboard and make sure this class is selected in the desired ViewController's attributes


// For the UI, we will have a vertical StackView as our base, and have horizontal StackViews inside (each with Buttons)


import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // to add IBOutlets without assistant editor:
    //      type IBOutlets in ViewController file
    //      in storyboard, Control+Drag from ViewController to UIElement (like UIButton), and select desired IBOutlet
    
    // outlets for all the effect buttons:
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highpitchButton: UIButton!
    @IBOutlet weak var lowpitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    // to add IBActions without assistant editor:
    //      type IBAction functions in ViewController file
    //      in storyboard, Control+Drag from UIElement (like UIButton) to ViewController, then select desired IBAction
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        // distinguish between Buttons using the tag property! (set each Button's tag property in storyboard)
        // use the enum above to distinguish!
        
        // sender.tag can be in the range 0-5, so use the rawValue!
        switch ButtonType(rawValue: sender.tag)! {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        // stops the audio playback:
        stopAudio()
    }
    
    
    
    // instructor's code:
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // updates the Content Mode of the images used in all the effect Buttons:
        // (solution: https://stackoverflow.com/questions/38697032/how-to-center-an-image-inside-an-uibutton-without-stretching-in-both-direction-i)
        slowButton.imageView?.contentMode = .scaleAspectFit
        fastButton.imageView?.contentMode = .scaleAspectFit
        highpitchButton.imageView?.contentMode = .scaleAspectFit
        lowpitchButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        
        // properly setup the AVAudioEngine:
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // make stop button disabled:
        configureUI(.notPlaying)    // this is from enum PlayingState
        
        // this also works (but is longer):
        // configureUI(PlayingState.notPlaying)
    }
}
