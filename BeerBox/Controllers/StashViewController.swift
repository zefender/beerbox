//
// Created by Кузяев Максим on 14.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class StashViewController: UIViewController, BeerStashViewDelegate {
    private let stashView = BeerStashView(frame: UIScreen.mainScreen().bounds)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Stash"

        automaticallyAdjustsScrollViewInsets = false

        stashView.delegate = self
    }

    func showStash(stash: [BeerItem]) {
        stashView.showStash(stash)
    }

    override func loadView() {
        view = stashView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        stashView.setInsets(UIEdgeInsets(top: topLayoutGuide.length, left: 0, bottom: 0, right: 0))
    }


    func beerStashView(view: BeerStashView, didSelectItemWithIndex index: Int) {
        let controller = BeerViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
