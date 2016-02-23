//
//  APIClient.swift
//  OnTheMap
//
//  Created by Кузяев Максим on 18.10.15.
//  Copyright © 2015 zefender. All rights reserved.
//

import Foundation

class APIClient {
    private let endPoint = "https://api.untappd.com/v4"

    func sendRequest(request: Request, completionHandler: (NSData?, Error?) -> Void) {
        let urlString = "\(endPoint)/\(request.method())"
        let httpRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        httpRequest.HTTPMethod = request.httpMethod().rawValue

        configureHttpRequest(httpRequest)

        if let parametersString = buildHttpBodyString(request.parameters()) {
            print("parametersString = \(parametersString)")
            httpRequest.HTTPBody = parametersString.dataUsingEncoding(NSUTF8StringEncoding)
        }

        let session = NSURLSession.sharedSession()

        let task = session.dataTaskWithRequest(httpRequest) {
            data, response, error in
            dispatch_async(dispatch_get_main_queue(), {
                () -> Void in
                let customError = Error(error: error)

                completionHandler(data, customError)
            })
        }

        task.resume()
    }


    func loadWithUrl(url: NSURL, completionHandler: (NSData?, Error) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
            data, response, error in
            let httpResponse = response as! NSHTTPURLResponse
            if httpResponse.statusCode == 200 {
                dispatch_async(dispatch_get_main_queue(), {
                    let customError = Error(error: error)

                    completionHandler(data, customError)
                })
            }
        })

        task.resume()
    }


    // To override
    func configureHttpRequest(request: NSMutableURLRequest) {

    }


    // To override 
    func buildHttpBodyString(parameters: [String:AnyObject]?) -> String? {
        return ""
    }

    // To override 
    func buildHttpCookie(request: NSMutableURLRequest) {

    }
}
