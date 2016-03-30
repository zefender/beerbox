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

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "moreDidTapped:")

        if let beer = beer as BeerItem? {
            beerView.setBeer(beer)
            beerView.setBeerImage(DataManager.instance.photoForBeer(beer))
            title = beer.name

            if let brewery = DataManager.instance.brewery(beer.breweryId) {
                beerView.setBrewery(brewery)
            }
        }
    }
    
    func moreDidTapped(sender: AnyObject) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
    
        let deleteAction = UIAlertAction(title: "Delete from stash", style: .Destructive) { action in
            if let beer = self.beer {
                DataManager.instance.removeBeerFromStash(beer)
                self.navigationController?.popViewControllerAnimated(true)
                self.delegate?.beerViewControllerDidDeleteBeerFromStash(self)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        controller.addAction(deleteAction)
        controller.addAction(cancelAction)
        
        presentViewController(controller, animated: true, completion: nil)
    }


    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        beerView.setInsets(UIEdgeInsets(top: topLayoutGuide.length, left: 0, bottom: 0, right: 0))
    }

}
