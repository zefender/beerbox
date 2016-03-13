//
// Created by Кузяев Максим on 23.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    func showAlertForError(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))

        self.presentViewController(alertController, animated: true, completion: nil)
    }

    override func shouldAutorotate() -> Bool {
        return false
    }
}
