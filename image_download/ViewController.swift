//
//  ViewController.swift
//  image_download
//
//  Created by Adygzhy Ondar on 16/04/15.
//  Copyright (c) 2015 Adygzhy Ondar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    /*
    // use dispatch
//    let imageQueue = dispatch_queue_create("loading image", nil);
//    let imagePath = "http://upload.wikimedia.org/wikipedia/commons/6/6b/Big_Sur_June_2008.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        //let imageQueue = dispatch_queue_create("loading image", nil);
        
        dispatch_async(imageQueue, {[weak self] in
            
            var image: UIImage?
            
            dispatch_sync(imageQueue, {
                // dowload image on the imageQueue
                let imagePath = "http://upload.wikimedia.org/wikipedia/commons/6/6b/Big_Sur_June_2008.jpg"
                
                if let url = NSURL(string: imagePath) {
                    if let data = NSData(contentsOfURL: url) {
                        image = UIImage(data: data)
                        /*
                        if let image = UIImage(data: data) {
                            self!.imageView.image = image
                        }
                        */
                    }
                }
            })
        
            dispatch_sync(dispatch_get_main_queue(), {
                // show image on the main queue
                self!.imageView.image = image
                
            })
        })
    }
    */
    
    
    let imagePath = "http://upload.wikimedia.org/wikipedia/commons/6/6b/Big_Sur_June_2008.jpg"
    
    var image: UIImage?

    
    lazy var loadingOperation: NSBlockOperation = {
        return NSBlockOperation(block: { [weak self] ()-> Void in
            if let strongSelf = self {
                switch Helper.fileLoadingClosure(strongSelf.imagePath) {
                case .Success(let data):
                    strongSelf.image = UIImage(data: data)
                    break
                case .Error(let errorDescription):
                    println("error")
                    break
                }
            }
        })
    }()


    lazy var updateUIOperation: NSBlockOperation = {
        return NSBlockOperation(block: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.imageView.image = strongSelf.image
            }
        })
    }()

    lazy var loadingImageOperationQueue: NSOperationQueue = {
        let result = NSOperationQueue()
        result.maxConcurrentOperationCount = 2
        result.qualityOfService = .UserInitiated
        return result
        }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("in viewDidLoad")
        self.updateUIOperation.addDependency(self.loadingOperation)
        loadingImageOperationQueue.addOperation(self.loadingOperation)
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.loadingImageOperationQueue.cancelAllOperations()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadingImageOperationQueue.addOperation(self.updateUIOperation)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

