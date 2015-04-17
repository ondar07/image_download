//
//  helper.swift
//  image_download
//
//  Created by Adygzhy Ondar on 17/04/15.
//  Copyright (c) 2015 Adygzhy Ondar. All rights reserved.
//

import Foundation

enum FileLoadingResultStatus {
    case Success(NSData)
    case Error(String)
}

class Helper {
    class var boolExample: Bool {
        return false
    }
    
    class var fileLoadingClosure: (String) -> FileLoadingResultStatus {
        return { (path: String) in
            if let url = NSURL(string: path) {
                if let data = NSData(contentsOfURL: url) {
                    return .Success(data)
                }
                else {
                    return .Error("failed to init data from url \(url)")
                }
            }
            return .Error("failed to init NSURL with string \(path)")
        }
    }
}