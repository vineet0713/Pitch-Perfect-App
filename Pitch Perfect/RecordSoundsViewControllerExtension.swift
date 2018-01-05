//
//  RecordSoundsViewControllerExtension.swift
//  Pitch Perfect
//
//  Created by Vineet Joshi on 1/5/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import Foundation

import AVFoundation
import UIKit

// this extension is added to extract delegate handling code from RecordSoundsViewController
// as a result, the RecordSoundsViewController doesn't have to conform to AVAudioRecorderDelegate

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    // adds the function from AVAudioRecorderDelegate:
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // used to call the 'stopRecording' segue!
        
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful.")
            
            // add a UIAlertController to show alert message:
            let alert = UIAlertController(title: "Alert", message: "Recording was not successful.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
