//
// Created by Кузяев Максим on 14.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class PopularViewController: ViewController, PopularViewDelegate {
    private let beerSearchView = PopularView(frame: UIScreen.mainScreen().bounds)
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

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "SearchIcon"), style: .Plain,
                target: self, action: "handleSearchButtonTap:")

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

    func handleSearchButtonTap(sender: AnyObject) {
        let controller = SearchViewController()
        navigationController?.presentViewController(controller, animated: true, completion: nil)
    }


    func popularView(view: PopularView, didTriggerStashActionForIndex index: Int) {
        DataManager.instance.addBeerToStash(beers[index].bid) {
            error in
            if error.hasError {
                self.showAlertForError(error)
            }
        }
    }
}