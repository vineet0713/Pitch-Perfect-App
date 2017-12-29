//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Vineet Joshi on 12/29/17.
//  Copyright © 2017 Vineet Joshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Start of my code:
    
    // use IBAction to connect the Button to the ViewController
    // (links the pressing of the Button to a function in ViewController)
    // Target-Action (where Target is the ViewController, Action is the function)
    @IBAction func recordAudio(_ sender: Any) {
        print("Record Button was pressed!")
        recordingLabel.text = "Recording in Progress!"
    }
    // above: an example of going from a UI element (the Button) to code - using IBAction
    
    // Going the other way (from code to UI element):
    // use IBOutlet! (in other words, an outlet from the code to the UI element)
    
    // We want to make a connection from the code to the "Tap to Record" Label
    @IBOutlet weak var recordingLabel: UILabel!
    // (preferably, we should put IBOutlets to be placed at the top of the class)
    // Now we can use this IBOutlet to change the Label (like its text)
    
    // Now we need an IBAction for the "Stop Recording" Button:
    @IBAction func stopRecordingAudio(_ sender: Any) {
        print("Stop Recording Button was pressed!")
        recordingLabel.text = "Tap to Record"
    }
    
    // The UIKit framework (provided by Apple) has many classes:
    // UILabel, UIButton, UIView, UIViewController, etc.
    
}

