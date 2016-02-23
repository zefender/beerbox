//
//  Request.swift
//  OnTheMap
//
//  Created by Кузяев Максим on 18.10.15.
//  Copyright © 2015 zefender. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
}

class Request {
    func httpMethod() -> HTTPMethod {
        return HTTPMethod.GET
    }
    
    func parameters() -> [String : AnyObject]? {
        return nil
    }
    
    func method() -> String {
        return ""
    }
    
    func path() -> String {
        return ""
    }
    
    func queryString() -> String {
        return ""
    }
}
