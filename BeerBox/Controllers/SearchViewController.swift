//
// Created by Кузяев Максим on 14.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, BeerSearchViewDelegate {
    private let beerSearchView = BeerSearchView(frame: UIScreen.mainScreen().bounds)


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
        if let path = NSBundle.mainBundle().pathForResource("beers", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let parser = BeerListParser(data: jsonData)
                let parsed = parser.parse() as! BeerListResponse
                beerSearchView.showBeers(parsed)
            } catch {
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
                let parsed = parser.parse() as! BeerListResponse
                controller.showStash(parsed.beers!)
            } catch {
            }
        }


    }

    func beerSearchView(view: BeerSearchView, didSelectIndex index: Int) {

    }

}
