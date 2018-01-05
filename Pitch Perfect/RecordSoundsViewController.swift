//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Vineet Joshi on 12/29/17.
//  Copyright © 2017 Vineet Joshi. All rights reserved.
//

// To see documentation (Ex. for UIViewController), do Option + Click

import UIKit

// for recording/storing the audio
import AVFoundation

// we must specify that the RecordSoundsViewController conforms to the AVAudioRecorder delegate protocol
// (we will implement a function from that delegate protocol, and our ViewController can act as the delegate to the AVAudioRecorder

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stopRecordingButton.isEnabled = false
    }
    
    
    // Start of my code:
    
    // use IBAction to connect the Button to the ViewController
    // (links the pressing of the Button to a function in ViewController)
    // Target-Action (where Target is the ViewController, Action is the function)
    @IBAction func recordAudio(_ sender: Any) {
        configureUI(labelText: "Recording in Progress!", recordingEnabled: false)
        
        // Instructor's code:
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        // sets this ViewController as the delegate
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
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
        configureUI(labelText: "Tap to Record", recordingEnabled: true)
        
        // Instructor's code:
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    // function to enable/disable the Buttons:
    func configureUI(labelText: String, recordingEnabled: Bool) {
        recordingLabel.text = labelText
        recordButton.isEnabled = recordingEnabled
        stopRecordingButton.isEnabled = !recordingEnabled
    }
    
    // The UIKit framework (provided by Apple) has many classes:
    // UILabel, UIButton, UIView, UIViewController, etc.
    
    
    
    // We need to disable the "Stop Recording" button when app is first opened,
    // and we need to disable the "Start Recording" button while it is recording
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    // this property allows this ViewController to use and reference the audioRecorder in multiple places
    var audioRecorder: AVAudioRecorder!
    
    
    
    // adds the function from AVAudioRecorderDelegate:
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // used to call the 'stopRecording' segue!
        
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful.")
        }
    }
    
    
    // this function is called (in THIS ViewController) once the segue above is triggered:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            // we can use 'as!' (forced upcast) because we know segue.destination will be of type PlaySoundsViewController
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            // sets the value of recordedAudioURL in the PlaySoundsViewController class
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}


// USEFUL: How to properly rename IBOutlets:
// https://stackoverflow.com/questions/37313374/how-to-rename-the-iboutlet-property-without-lose-the-connection



// Notes from lecture videos:
/*
 "ViewController and Multiple Views" lesson notes:
 
 Application Lifecycle: the set of states that an app can move through from the OS's perspective
 5 States of Application Lifecycle:
 Not Running
 Inactive
 Active
 Background
 Suspended
 
 Our app can only run when it is in the Foreground (Inactive, Active states) or the Background (Background state)
 
 In the beginning, our app is in Not Running state
 When the user taps the app icon, it moves to the Inactive state (where it does some setup, but can't yet receive events)
 Then it moves into the Active state, when it's fully running in the Foreground and receiving events
 When a device event happens (Ex. phone call, user switches to another app), the app goes back into Inactive state
 Then the app goes into Background state (it can still execute select code, but it's interface is not showing)
 After a few seconds, app will go into Suspended state (app is still in memory but cannot execute any code!)
 Now two things can happen:
 If the user comes back to the app, it goes back to Background state, then Inactive state, then Active state
 If iOS needs more memory, the app will be moved off memory entirely, and app will go to Not Running state
 
 
 See documentation for UIViewController and its viewDidLoad() function!
 viewDidLoad() is called when the ViewController is loaded into memory, even before it is shown on screen
 viewWillAppear() is called only when the ViewController is about to be presented on the screen
 
 Important: viewDidLoad() gets called BEFORE viewWillAppear(), which gets called BEFORE viewDidAppear()
 
 Important: in iOS, the 'will' functions always get called BEFORE the 'did' functions
 
 
 
 
 
 
 2 common classes for handling multiple ViewControllers:
 UINavigationController
        handles a stack of ViewControllers (like a stack of pancakes on a dish)
        the UINavigationController is like a plate, and we can add ViewControllers (pancakes!) on top
        a UINavigationController always starts out with a root ViewController (so stack can never be empty!)
 UITabBarController
 
 
 To insert a UINavigationController (or anything else to handle multiple ViewControllers):
    Go to Main.storyboard, and click Editor -> Embed in -> Navigation Controller
 
 To add a new ViewController to a UINavigationController (or anything else to handle multiple ViewControllers):
    Go to Main.storyboard, and drag a ViewController onto the storyboard
    Control+Click from a Button onto the new ViewController (this makes a segue!)
 
 
 
 
 
 
 AVFoundation (A is Audio, V is Video) is an iOS framework that processes audio and video
 
 
 
 
 
 
 To setup a segue programmatically (instead of through storyboard):
    Create a segue from the first ViewController to second ViewController (NOT from button to second ViewController)
    Set the identifier of the segue
    Use the performSegue method
 
 
 
 In a delegate relationship, one entity gets another entity to do some work for them
 (and the second entity can notify the first entity when the work gets done)
 
 */
