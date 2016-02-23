//
// Created by Кузяев Максим on 22.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation

class BeerListRequest: Request {
    override func httpMethod() -> HTTPMethod {
        return .GET
    }

    override func parameters() -> [String:AnyObject]? {
        return super.parameters()
    }

    override func method() -> String {
        return super.method()
    }

    override func path() -> String {
        return super.path()
    }

    override func queryString() -> String {
        return super.queryString()
    }

}
