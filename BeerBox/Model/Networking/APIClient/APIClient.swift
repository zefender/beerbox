//
//  APIClient.swift
//  OnTheMap
//
//  Created by Кузяев Максим on 18.10.15.
//  Copyright © 2015 zefender. All rights reserved.
//

import Foundation

class APIClient {
    private let clientID = "90918F677B9D5DD2AC12FC2E082A645C30547182"
    private let clientSecret = "35ACA978EB6E99F9036F0F591E36667AE08CA86A"
    private let endPoint = "https://api.untappd.com/v4"

    func sendRequest(request: Request, completionHandler: (NSData?, Error) -> Void) {
        let urlString = "\(endPoint)/\(request.method())?client_id=\(clientID)&client_secret=\(clientSecret)&\(request.queryString().stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)"

        if let url = NSURL(string: urlString) {
            let httpRequest = NSMutableURLRequest(URL: url)
            httpRequest.HTTPMethod = request.httpMethod().rawValue

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
    }


    func loadWithUrl(url: NSURL, completionHandler: (NSData?, Error) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
            data, response, error in
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    dispatch_async(dispatch_get_main_queue(), {
                        let customError = Error(error: error)

                        completionHandler(data, customError)
                    })
                }
            }
        })

        task.resume()
    }
}
