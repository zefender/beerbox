
//
//  Parser.swift
//  OnTheMap
//
//  Created by Кузяев Максим on 18.10.15.
//  Copyright © 2015 zefender. All rights reserved.
//

import Foundation

class Parser {
    private let data: NSData
    
    init(data: NSData) {
        self.data = data
    }
    
    func parse() -> Any? {
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            return scanObject(object as! [String : AnyObject])
        } catch let caught as NSError {
            print(caught.description)
        }
        
        return nil
    }
    
    // To override. Factory method
    func scanObject(parsedJson: [String:AnyObject]) -> Any? {
        return nil
    }
}
