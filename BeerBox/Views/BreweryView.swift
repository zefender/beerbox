//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Cosmos
import CoreLocation


protocol BreweryViewDelegate: class {
    func breweryViewDidTriggerCloseAction(view: BreweryView)
}


class BreweryView: UIView, MKMapViewDelegate {
    weak var delegate: BreweryViewDelegate?

    private var brewery: BreweryItem?

    private let closeButton: UIButton = UIButton()
    private let mainContainer: ShadowView = ShadowView()
    private let mapContainer: ShadowView = ShadowView()
    private let contentContainer: UIScrollView = UIScrollView()
    private let imageContainer: ShadowView = ShadowView()
    private let nameLabel: UILabel = UILabel()
    private let addressLabel: UILabel = UILabel()
    private let descrLabel: UILabel = UILabel()
    private let breweryImage: UIImageView = UIImageView()
    private let ratingControl: CosmosView = CosmosView()

    private let mapView: MKMapView = MKMapView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Colors.tintColor

        closeButton.addTarget(self, action: "closeButtonDidTapped:", forControlEvents: .TouchUpInside)
        closeButton.setTitle("Close", forState: .Normal)

        nameLabel.textAlignment = .Center
        nameLabel.textColor = Colors.tintColor
        nameLabel.font = UIFont(name: "Helvetica", size: 20)
        nameLabel.numberOfLines = 2

        addressLabel.textAlignment = .Center
        addressLabel.textColor = Colors.grayFont
        addressLabel.font = UIFont(name: "Helvetica", size: 13)
        addressLabel.numberOfLines = 1

        descrLabel.textAlignment = .Center
        descrLabel.textColor = Colors.tintColor
        descrLabel.font = UIFont(name: "Helvetica", size: 14)
        descrLabel.numberOfLines = 0

        mainContainer.setCornerRaduis(4)
        mainContainer.setBackGroundColor(Colors.background)
        
        contentContainer.layer.cornerRadius = 4
        mapView.layer.cornerRadius = 4

        mapView.userInteractionEnabled = false
        mapView.delegate = self

        imageContainer.setCornerRaduis(4)

        ratingControl.rating = 4
        ratingControl.settings.starSize = 18
        ratingControl.settings.emptyColor = Colors.disabled
        ratingControl.settings.emptyBorderColor = Colors.disabled
        ratingControl.settings.filledBorderWidth = 0
        ratingControl.settings.filledColor = Colors.orangeFont
        ratingControl.settings.fillMode = .Full
        ratingControl.settings.starMargin = 3

        addSubview(closeButton)
        addSubview(mainContainer)
        addSubview(imageContainer)
        imageContainer.addView(breweryImage)
        imageContainer.addView(ratingControl)
        mainContainer.addView(mapContainer)
        mainContainer.addSubview(contentContainer)
        contentContainer.addSubview(nameLabel)
        contentContainer.addSubview(addressLabel)
        contentContainer.addSubview(descrLabel)
        mapContainer.addView(mapView)
    }

    func closeButtonDidTapped(sender: AnyObject) {
        delegate?.breweryViewDidTriggerCloseAction(self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        closeButton.frame = CGRect(x: 0, y: 8, width: 50, height: 30)
        closeButton.right = width - 14

        imageContainer.frame = CGRect(x: 0, y: 27, width: 160, height: 188)
        imageContainer.centerX = bounds.centerX

        breweryImage.frame = CGRect(x: 12, y: 12, width: imageContainer.width - 24, height: 136)

        mainContainer.frame = CGRect(x: 32, y: 96, width: width - 64, height: height - 128)
        mapContainer.frame = CGRect(x: 0, y: 0, width: mainContainer.width, height: 180)
        contentContainer.frame = CGRect(x: 0, y: mapContainer.bottom, width: mainContainer.width,
                height: mainContainer.height - mapContainer.height)


        mapView.frame = CGRect(x: 0, y: 0, width: mapContainer.bounds.width, height: mapContainer.bounds.height)

        let contentWidth = mainContainer.width - 48

        nameLabel.frame = CGRect(x: 0, y: 24, width: contentWidth, height: 0)
        nameLabel.sizeToFit()
        nameLabel.centerX = mainContainer.bounds.centerX

        addressLabel.frame = CGRect(x: 0, y: nameLabel.bottom + 8, width: contentWidth, height: 0)
        addressLabel.sizeToFit()
        addressLabel.centerX = mainContainer.bounds.centerX

        descrLabel.frame = CGRect(x: 0, y: addressLabel.bottom + 8, width: contentWidth, height: 0)
        descrLabel.sizeToFit()
        descrLabel.centerX = mainContainer.bounds.centerX

        ratingControl.frame = CGRect(x: 12, y: breweryImage.bottom + 8, width: 100, height: 16)
        ratingControl.centerX = imageContainer.bounds.centerX
        ratingControl.bottom = imageContainer.bounds.bottom - 16

        contentContainer.contentSize = CGSize(width: mainContainer.width, height:
        descrLabel.bottom + 24)
    }

    func setBrewery(brewery: BreweryItem) {
        self.brewery = brewery

        nameLabel.text = brewery.name
        addressLabel.text = brewery.address
        descrLabel.text = brewery.about
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: brewery.lat, longitude: brewery.lon)
        mapView.showAnnotations([annotation], animated: false)
    }

    func setBreweryImage(image: UIImage?) {
        breweryImage.image = image
    }

    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        if let brewery = brewery {
            var center = CLLocationCoordinate2D(latitude: brewery.lat, longitude: brewery.lon)
            center.latitude += mapView.region.span.latitudeDelta * 0.4;
            mapView.setCenterCoordinate(center, animated: false)
        }
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
