//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit


protocol BeerViewControllerDelegate: class {
    func beerViewControllerDidDeleteBeerFromStash(controller: BeerViewController)
}


class BeerViewController: UIViewController, BeerViewDelegate {
    weak var delegate: BeerViewControllerDelegate?

    private let beerView = BeerView(frame: UIScreen.mainScreen().bounds)

    var beer: BeerItem?

    func beerViewDidTriggerBreweryAction(view: BeerView) {
       let controller = BreweryViewController()
       navigationController?.presentViewController(controller, animated: true, completion: nil)
    }

    func beerViewDidTriggerRemoveAction(view: BeerView) {
        if let beer = beer {
            DataManager.instance.removeBeerFromStash(beer)
            navigationController?.popViewControllerAnimated(true)
            delegate?.beerViewControllerDidDeleteBeerFromStash(self)
        }
    }


    override func loadView() {
        beerView.delegate = self
        view = beerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        beerView.setName("Punk IPA")
//        beerView.set
    }


}
