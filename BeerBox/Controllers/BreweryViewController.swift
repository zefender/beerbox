//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit


class BreweryViewController: UIViewController, BreweryViewDelegate {
    private let breweryView: BreweryView = BreweryView()

    var breweryId: Int?

    override func loadView() {
        breweryView.delegate = self
        view = breweryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let breweryId = breweryId {
            if let brewery = DataManager.instance.brewery(breweryId) {
                breweryView.setBrewery(brewery)
                breweryView.setBreweryImage(DataManager.instance.photoForBrewery(brewery))
            }
        }
    }


    func breweryViewDidTriggerCloseAction(view: BreweryView) {
         dismissViewControllerAnimated(true, completion: nil)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}
