//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class BeerViewController: UIViewController, BeerViewDelegate {
    private let beerView = BeerView(frame: UIScreen.mainScreen().bounds)

    func beerViewDidTriggerBreweryAction(view: BeerView) {
       let controller = BreweryViewController()
       navigationController?.presentViewController(controller, animated: true, completion: nil)
    }


    override func loadView() {
        beerView.delegate = self
        view = beerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        beerView.setName("Punk IPA")
    }


}
