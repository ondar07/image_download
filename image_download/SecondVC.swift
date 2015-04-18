//
//  SecondVC.swift
//  image_download
//
//  Created by Adygzhy Ondar on 18/04/15.
//  Copyright (c) 2015 Adygzhy Ondar. All rights reserved.
//

import Foundation
import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var urlString: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //
        if(segue.identifier == "urlDone") {
            var VC: ViewController = segue.destinationViewController as! ViewController
            VC.imagePath = urlString.text
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}