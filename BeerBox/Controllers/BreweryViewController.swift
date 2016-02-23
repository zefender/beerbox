//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit


class BreweryViewController: UIViewController, BreweryViewDelegate {
    private let breweryView = BreweryView()

    override func loadView() {
        breweryView.delegate = self
        view = breweryView
    }

    func breweryViewDidTriggerCloseAction(view: BreweryView) {
         dismissViewControllerAnimated(true, completion: nil)
    }

}
