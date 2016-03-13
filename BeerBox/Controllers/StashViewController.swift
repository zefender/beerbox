//
// Created by Кузяев Максим on 14.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class StashViewController: UIViewController, BeerStashViewDelegate, BeerViewControllerDelegate {
    private let stashView = BeerStashView(frame: UIScreen.mainScreen().bounds)
    private var stash: [BeerItem]?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Stash"

        automaticallyAdjustsScrollViewInsets = false

        stashView.delegate = self

        reloadStash()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.topItem?.title = "S T A S H"
    }


    private func reloadStash() {
        if let beers = DataManager.instance.fetchStash() {
            stash = beers
            stashView.showStash(beers)
        }
    }

    override func loadView() {
        view = stashView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        stashView.setInsets(UIEdgeInsets(top: topLayoutGuide.length + 24, left: 0, bottom: 0, right: 0))
    }

    func beerViewControllerDidDeleteBeerFromStash(controller: BeerViewController) {
        reloadStash()
    }


    func beerStashView(view: BeerStashView, didSelectItemWithIndex index: Int) {
        if let stash = stash {
            let controller = BeerViewController()
            controller.delegate = self
            let beer = stash[index]
            controller.beer = beer

            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
