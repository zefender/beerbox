//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit
import MapKit


protocol BreweryViewDelegate: class {
   func breweryViewDidTriggerCloseAction(view: BreweryView)
}


class BreweryView: UIView {
    weak var delegate: BreweryViewDelegate?

    private let closeButton: UIButton = UIButton()
    private let mapView: MKMapView = MKMapView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.lightGrayColor()

        closeButton.addTarget(self, action: "closeButtonDidTapped:", forControlEvents: .TouchUpInside)
        closeButton.setTitle("X", forState: .Normal)

        addSubview(closeButton)
        addSubview(mapView)
    }

    func closeButtonDidTapped(sender: AnyObject) {
        delegate?.breweryViewDidTriggerCloseAction(self)
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        closeButton.frame = CGRect(x: width - 52, y: 8, width: 44, height: 44)
        mapView.frame = CGRect(x: 0, y: 60, width: width, height: 100)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
