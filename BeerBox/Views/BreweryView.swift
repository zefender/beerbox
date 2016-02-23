//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit


protocol BreweryViewDelegate: class {
   func breweryViewDidTriggerCloseAction(view: BreweryView)
}


class BreweryView: UIView {
    weak var delegate: BreweryViewDelegate?

    private let closeButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.lightGrayColor()

        closeButton.addTarget(self, action: "closeButtonDidTapped:", forControlEvents: .TouchUpInside)
        closeButton.setTitle("X", forState: .Normal)

        addSubview(closeButton)
    }

    func closeButtonDidTapped(sender: AnyObject) {
        delegate?.breweryViewDidTriggerCloseAction(self)
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        closeButton.frame = CGRect(x: width - 52, y: 8, width: 44, height: 44)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
