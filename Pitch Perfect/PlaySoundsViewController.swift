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

class PlaySoundsViewController: UIViewController {
    var recordedAudioURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
