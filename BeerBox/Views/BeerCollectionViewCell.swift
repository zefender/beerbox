//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    static let cellId = "BeerCollectionViewCellId"

    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let beerImage = UIImageView()
    private let ibuLabel = UILabel()
    private let abvLabel = UILabel()
    private let styleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.orangeColor()

        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(beerImage)
        contentView.addSubview(ibuLabel)
        contentView.addSubview(abvLabel)
        contentView.addSubview(styleLabel)
    }

    func setName(name: String) {
        nameLabel.text = name
    }
    func setDescription(description: String) {
        descriptionLabel.text = description
    }
    func setBeerImage(image: UIImage) {
        beerImage.image = image
    }
    func setIBU(ibu: String) {
        ibuLabel.text = ibu
    }
    func setABV(abv: String) {
        abvLabel.text = abv
    }
    func setStyle(style: String) {
        styleLabel.text = style
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        nameLabel.frame = CGRect(x: 0, y: 8, width: width, height: 44)

        descriptionLabel.frame = CGRect(x: 0, y: nameLabel.bottom, width: width, height: 44)
        beerImage.frame = CGRect(x: 0, y: descriptionLabel.bottom, width: width, height: 100)
        ibuLabel.frame = CGRect(x: 0, y: beerImage.bottom, width: width, height: 44)
        abvLabel.frame = CGRect(x: 0, y: ibuLabel.bottom, width: width, height: 44)
        styleLabel.frame = CGRect(x: 0, y: nameLabel.bottom + 8, width: width, height: 44)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        descriptionLabel.text = nil
        beerImage.image = nil
        ibuLabel.text = nil
        abvLabel.text = nil
        styleLabel.text = nil
    }


}
