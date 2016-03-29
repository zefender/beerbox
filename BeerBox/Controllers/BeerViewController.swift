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
        if let beer = beer {
            let controller = BreweryViewController()
            controller.breweryId = beer.breweryId
            presentViewController(controller, animated: true, completion: nil)
        }
    }

    override func loadView() {
        beerView.beerViewDelegate = self
        view = beerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: ""), style: .Plain, target: self,
                action: "deleteFromStashDidTapped:")

        if let beer = beer as BeerItem? {
            beerView.setBeer(beer)
            beerView.setBeerImage(DataManager.instance.photoForBeer(beer))
            title = beer.name

            if let brewery = DataManager.instance.brewery(beer.breweryId) {
                beerView.setBrewery(brewery)
            }
        }
    }

    func deleteFromStashDidTapped(sender: AnyObject) {
        if let beer = beer {
            DataManager.instance.removeBeerFromStash(beer)
            navigationController?.popViewControllerAnimated(true)
            delegate?.beerViewControllerDidDeleteBeerFromStash(self)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        beerView.setInsets(UIEdgeInsets(top: topLayoutGuide.length, left: 0, bottom: 0, right: 0))
    }

}
