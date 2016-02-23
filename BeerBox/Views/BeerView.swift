//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit


protocol BeerViewDelegate: class {
    func beerViewDidTriggerBreweryAction(view: BeerView)
}

class BeerView: UIView {
    weak var delegate: BeerViewDelegate?

    private let breweryButton: UIButton = UIButton()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let beerImage = UIImageView()
    private let ibuLabel = UILabel()
    private let abvLabel = UILabel()
    private let styleLabel = UILabel()


    func setName(name: String) {
        nameLabel.text = name
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.brownColor()

        breweryButton.setTitle("Brewery", forState: .Normal)
        breweryButton.addTarget(self, action: "breweryButtonDidTapped:", forControlEvents: UIControlEvents.TouchUpInside)

        addSubview(breweryButton)

        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(beerImage)
        addSubview(ibuLabel)
        addSubview(abvLabel)
        addSubview(styleLabel)
    }

    func breweryButtonDidTapped(sender: AnyObject) {
       delegate?.beerViewDidTriggerBreweryAction(self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 44)
        breweryButton.frame = CGRect(x: 0, y: height - 44, width: 100, height: 44)
        breweryButton.centerX = centerX
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
