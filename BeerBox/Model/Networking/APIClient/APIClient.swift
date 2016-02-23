//
//  APIClient.swift
//  OnTheMap
//
//  Created by Кузяев Максим on 18.10.15.
//  Copyright © 2015 zefender. All rights reserved.
//

import Foundation

class APIClient {
    func sendRequest(request: Request, completionHandler: (NSData?, NSError?) -> Void) {
        let urlString = "\(baseApiUrl())/\(request.method())"
        let httpRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        httpRequest.HTTPMethod = request.httpMethod().rawValue
        
        configureHttpRequest(httpRequest)
        
        if let parametersString = buildHttpBodyString(request.parameters()) {
            print("parametersString = \(parametersString)")
            httpRequest.HTTPBody = parametersString.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        if request.shouldAddCookie() {
            buildHttpCookie(httpRequest)
        }
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(httpRequest) { data, response, error in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completionHandler(self.handleResponse(data), error)
            })
        }
        
        task.resume()
    }
    
    // To override
    func configureHttpRequest(request: NSMutableURLRequest) {
        
    }
    
    // To override
    func baseApiUrl() -> String {
        return ""
    }
    
    // To override
    func handleResponse(response: NSData?) -> NSData? {
        return nil
    }
    
    // To override 
    func buildHttpBodyString(parameters: [String: AnyObject]?) -> String? {
        return ""
    }
    
    // To override 
    func buildHttpCookie(request: NSMutableURLRequest) {
        
    }
}
