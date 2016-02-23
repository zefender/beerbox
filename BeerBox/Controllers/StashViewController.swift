//
// Created by Кузяев Максим on 14.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class BoxViewController: UIViewController {
    private let stashView = BeerStashView(frame: UIScreen.mainScreen().bounds)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Stash"
    }

    override func loadView() {
        view = stashView
    }

}
