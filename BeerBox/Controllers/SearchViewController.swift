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

        title = "BeerBox"
        beerSearchView.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stash", style: .Plain, target: self, action:
        "handleStashButtonTap:")

        fetchBeers()
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
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = true

                    DataManager.instance.loadPhotoForUrl(url) {
                        (image, error) -> () in
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false

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

        if let path = NSBundle.mainBundle().pathForResource("beers", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let parser = BeerListParser(data: jsonData)
                let parsed = parser.parse() as! BeerList
                controller.showStash(parsed.beers!)
            } catch {
            }
        }


    }

    func beerSearchView(view: BeerSearchView, didTriggerStachActionForIndex index: Int) {
        DataManager.instance.addBeerToStash(beers[index])
    }

}