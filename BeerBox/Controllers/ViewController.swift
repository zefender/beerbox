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

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = Colors.tintColor
        navigationController?.navigationBar.titleTextAttributes =
                [NSFontAttributeName: UIFont(name: "Helvetica", size: 15)!,
                 NSForegroundColorAttributeName: Colors.tintColor]
    }

    func switchNetworkActivity(inProgress: Bool) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = inProgress
    }

}
