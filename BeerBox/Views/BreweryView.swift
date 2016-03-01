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

    private let shadowView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.lightGrayColor()

        closeButton.addTarget(self, action: "closeButtonDidTapped:", forControlEvents: .TouchUpInside)
        closeButton.setTitle("X", forState: .Normal)

        addSubview(closeButton)
        addSubview(mapView)
        addSubview(shadowView)
    }

    private func shadow() {
        shadowView.backgroundColor = UIColor.clearColor()

        let gradient = CAGradientLayer()
        gradient.frame = shadowView.bounds

        let innerColor = UIColor.clearColor().CGColor
        let outerColor = UIColor.whiteColor().CGColor

        gradient.colors = [outerColor, innerColor, outerColor]
        gradient.locations = [0.0, 0.5, 1.0]

        shadowView.layer.insertSublayer(gradient, atIndex: 0)
    }

    func closeButtonDidTapped(sender: AnyObject) {
        delegate?.breweryViewDidTriggerCloseAction(self)
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        closeButton.frame = CGRect(x: width - 52, y: 8, width: 44, height: 44)
        mapView.frame = CGRect(x: 0, y: 60, width: width, height: 100)
        shadowView.frame = CGRect(x: 20, y: 60, width: 200, height: 88)

        shadow()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
