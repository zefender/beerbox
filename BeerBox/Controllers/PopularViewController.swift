//
// Created by Кузяев Максим on 14.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class PopularViewController: ViewController, PopularViewDelegate, SearchViewDelegate {
    private let beerListView = PopularView(frame: UIScreen.mainScreen().bounds)
    private var beers = [BeerItem]()
    private var foundedBeers = [BeerItem]()
    private var searchButton: UIBarButtonItem!
    private var stashButton: UIBarButtonItem!

    override func loadView() {
        view = beerListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        beerListView.delegate = self
        automaticallyAdjustsScrollViewInsets = false

        searchButton = UIBarButtonItem(image: UIImage(named: "SearchIcon"), style: .Plain,
                target: self, action: "handleSearchButtonTap:")

        stashButton = UIBarButtonItem(image: UIImage(named: "StachIcon"), style: .Plain,
                target: self, action: "handleStashButtonTap:")

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        setDefaultsNavigationBarAppearance()

        fetchBeers()
    }

    func setDefaultsNavigationBarAppearance() {
        navigationItem.rightBarButtonItem = stashButton
        navigationItem.leftBarButtonItem = searchButton

        navigationController?.navigationBar.tintColor = Colors.tintColor
        navigationController?.navigationBar.topItem?.title = "P O P U L A R"
        navigationController?.navigationBar.titleTextAttributes =
                [NSFontAttributeName: UIFont(name: "Helvetica", size: 15)!,
                 NSForegroundColorAttributeName: Colors.tintColor]
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        beerListView.setInsets(UIEdgeInsets(top: topLayoutGuide.length + 24, left: 0, bottom: 0, right: 0))
    }


    private func fetchBeers() {
        DataManager.instance.searchBeersWithTerm("term") {
            (beers, error) in
            if error.hasError {
                self.showAlertForError(error)
            } else if let beers = beers {
                self.beers = beers

                self.beerListView.showBeers(beers, photoLoader: {
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
        let searchView = SearchView(frame: CGRect(x: 0, y: 0, width: navigationController?.navigationBar.width ?? 0 - 44,
                height: navigationController?.navigationBar.height ?? 0))
        searchView.setPlaceHolder("Type beer name")
        searchView.delegate = self
        searchView.setFirstResponder()

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchView)
        navigationItem.rightBarButtonItem = nil
    }


    func popularView(view: PopularView, didTriggerStashActionForIndex index: Int) {
        DataManager.instance.addBeerToStash(beers[index].bid) {
            error in
            if error.hasError {
                self.showAlertForError(error)
            }
        }
    }

    func searchViewDidTriggerCloseAction(view: SearchView) {
        setDefaultsNavigationBarAppearance()
    }
}