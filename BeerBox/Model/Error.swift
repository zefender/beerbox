//
// Created by Кузяев Максим on 23.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation

class Error {
    private let error: NSError?

    var errorMessage: String? {
        get {
            if let error = error {
                error.localizedDescription
            }

            return nil
        }
    }

    var hasError: Bool {
        get {
            return error != nil
        }
    }

    init(error: NSError?) {
        self.error = error
    }
}
