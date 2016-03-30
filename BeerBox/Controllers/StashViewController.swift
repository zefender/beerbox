//
// Created by Кузяев Максим on 14.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class StashViewController: ViewController, BeerStashViewDelegate, BeerViewControllerDelegate {
    private let stashView = BeerStashView(frame: UIScreen.mainScreen().bounds)
    private var stash: [BeerItem]?

    private var searchButton: UIBarButtonItem!
    private var settingsButton: UIBarButtonItem!


    // MARK: - VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false

        searchButton = UIBarButtonItem(image: UIImage(named: "SearchIcon"), style: .Plain,
                target: self, action: "handleSearchButtonTap:")
        
        settingsButton = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action:"settingsDidTapped:")

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        setDefaultsNavigationBarAppearance()

        stashView.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        reloadStash()
    }


    override func loadView() {
        view = stashView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        stashView.setInsets(UIEdgeInsets(top: topLayoutGuide.length + 24, left: 0, bottom: 0, right: 0))
    }

    // MARK: - Hadlers
    func handleSearchButtonTap(sender: AnyObject) {
        let controller = SearchViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func settingsDidTapped(sender: AnyObject) {
        let controller = SettingsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    func setDefaultsNavigationBarAppearance() {
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.leftBarButtonItem = settingsButton
        navigationController?.navigationBar.topItem?.title = "S T A S H"
    }

    private func reloadStash() {
        if let beers = DataManager.instance.fetchStash() {
            stash = beers
            stashView.showStash(beers)
        }
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
