//
// Created by Кузяев Максим on 14.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: ViewController, BeerSearchViewDelegate {
    private let beerSearchView = BeerSearchView(frame: UIScreen.mainScreen().bounds)
    private var beers = [BeerItem]()

    override func loadView() {
        view = beerSearchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        beerSearchView.delegate = self
        automaticallyAdjustsScrollViewInsets = false

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "StachIcon"), style: .Plain,
                target: self, action: "handleStashButtonTap:")

        let searchView: SearchView = SearchView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        searchView.placeHolderText = "Type beer name"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchView)

        fetchBeers()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        beerSearchView.setInsets(UIEdgeInsets(top: topLayoutGuide.length + 24, left: 0, bottom: 0, right: 0))
    }


    private func fetchBeers() {
        DataManager.instance.searchBeersWithTerm("term") {
            (beers, error) in
            if error.hasError {
                self.showAlertForError(error)
            } else if let beers = beers {
                self.beers = beers

                self.beerSearchView.showBeers(beers, photoLoader: {
                    (url, completionHandler) -> () in

                    DataManager.instance.loadPhotoForUrl(url) {
                        (image, error) -> () in

                        if error.hasError {
                            self.showAlertForError(error)
                        } else {
                            completionHandler(image)
                        }
                    }
                })
            }
        }
    }

    func handleStashButtonTap(sender: AnyObject) {
        let controller = StashViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    func beerSearchView(view: BeerSearchView, didTriggerStachActionForIndex index: Int) {
        DataManager.instance.addBeerToStash(beers[index])
    }

}