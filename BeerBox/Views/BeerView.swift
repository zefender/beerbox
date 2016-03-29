//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit
import Cosmos


protocol BeerViewDelegate: class {
    func beerViewDidTriggerBreweryAction(view: BeerView)
}

class BeerView: UIScrollView, BreweryButtonDelegate {
    weak var beerViewDelegate: BeerViewDelegate?

    private let topView: UIView = UIView()
    private let mainContainerView: UIView = UIView()
    private let imageContainerView: ShadowView = ShadowView()

    private let breweryButton: BreweryButton = BreweryButton()
    private let breweryButtonContainer: ShadowView = ShadowView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let beerImage = UIImageView()
    private let ibuLabel = UILabel()
    private let styleLabel = UILabel()
    private let ratingControl: CosmosView = CosmosView()


    func setBeer(beer: BeerItem) {
        nameLabel.text = beer.name
        styleLabel.text = beer.style
        ibuLabel.text = "IBU: \(beer.IBU)"
        descriptionLabel.text = beer.descr
    }

    func setBrewery(brewery: BreweryItem) {
        breweryButton.setCountryTitle(brewery.country)
        breweryButton.setTitle("Brewery")
        breweryButton.setNameTitle(brewery.name)
    }


    func setBeerImage(image: UIImage?) {
        beerImage.image = image
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        breweryButton.delegate = self
        breweryButtonContainer.setCornerRaduis(4)
        breweryButton.layer.cornerRadius = 4

        topView.backgroundColor = Colors.tintColor
        mainContainerView.backgroundColor = Colors.background
        backgroundColor = Colors.tintColor

        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .Center
        descriptionLabel.font = UIFont(name: "Helvetica", size: 14)
        descriptionLabel.textColor = Colors.tintColor

        nameLabel.textAlignment = .Center
        nameLabel.font = UIFont(name: "Helvetica", size: 24)
        nameLabel.textColor = Colors.tintColor

        styleLabel.textAlignment = .Center
        styleLabel.font = UIFont(name: "Helvetica", size: 13)
        styleLabel.textColor = Colors.grayFont

        ibuLabel.textAlignment = .Center
        ibuLabel.font = UIFont(name: "Helvetica", size: 13)
        ibuLabel.textColor = Colors.tintColor

        imageContainerView.setCornerRaduis(4)

        beerImage.layer.cornerRadius = 4

        addSubview(topView)
        addSubview(mainContainerView)
        addSubview(imageContainerView)

        imageContainerView.addView(beerImage)
        imageContainerView.addView(ratingControl)

        mainContainerView.addSubview(nameLabel)
        mainContainerView.addSubview(descriptionLabel)
        mainContainerView.addSubview(ibuLabel)
        mainContainerView.addSubview(styleLabel)
        mainContainerView.addSubview(breweryButtonContainer)
        breweryButtonContainer.addView(breweryButton)

        ratingControl.rating = 4
        ratingControl.settings.starSize = 18
        ratingControl.settings.emptyColor = Colors.disabled
        ratingControl.settings.emptyBorderColor = Colors.disabled
        ratingControl.settings.filledBorderWidth = 0
        ratingControl.settings.filledColor = Colors.orangeFont
        ratingControl.settings.fillMode = .Full
        ratingControl.settings.starMargin = 3
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        topView.frame = CGRect(x: 0, y: 0, width: width, height: 186)
        imageContainerView.frame = CGRect(x: 0, y: 24, width: 160, height: 205)
        imageContainerView.centerX = centerX

        let contentWidth = width - 48

        nameLabel.frame = CGRect(x: 0, y: 72, width: contentWidth, height: 22)
        nameLabel.sizeToFit()
        nameLabel.centerX = bounds.centerX

        styleLabel.frame = CGRect(x: 0, y: nameLabel.bottom + 8, width: contentWidth, height: 22)
        styleLabel.sizeToFit()
        styleLabel.centerX = bounds.centerX

        ibuLabel.frame = CGRect(x: 0, y: styleLabel.bottom + 8, width: contentWidth, height: 22)
        ibuLabel.sizeToFit()
        ibuLabel.centerX = bounds.centerX

        descriptionLabel.frame = CGRect(x: 0, y: ibuLabel.bottom + 16, width: contentWidth, height: 0)
        descriptionLabel.centerX = bounds.centerX
        descriptionLabel.sizeToFit()


        breweryButtonContainer.frame = CGRect(x: 0, y: descriptionLabel.bottom + 8, width: contentWidth, height: 64)
        breweryButtonContainer.centerX = bounds.centerX

        breweryButton.frame = breweryButtonContainer.bounds

        beerImage.frame = CGRect(x: 12, y: 12, width: 136, height: 136)
        ratingControl.frame = CGRect(x: 12, y: beerImage.bottom + 16, width: 100, height: 16)
        ratingControl.centerX = imageContainerView.bounds.centerX

        mainContainerView.frame = CGRect(x: 0, y: topView.bottom, width: width,
                height: topView.bottom + breweryButtonContainer.bottom + 24)

        contentSize = CGSize(width: width,height: mainContainerView.bounds.bottom)

    }

    func setInsets(insets: UIEdgeInsets) {
        contentInset = insets
    }

    func breweryButtonDidTapped(view: BreweryButton) {
        beerViewDelegate?.beerViewDidTriggerBreweryAction(self)
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
