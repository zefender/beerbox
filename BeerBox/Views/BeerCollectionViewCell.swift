//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    static let cellId = "BeerCollectionViewCellId"

    private let rigthOffset: CGFloat = 16

    private let nameLabel = UILabel()
    private let beerImage = UIImageView()
    private let ibuLabel = UILabel()
    private let styleLabel = UILabel()

    private let shadowView: UIView = UIView()
    private let containerView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.clearColor()
        shadowView.backgroundColor = UIColor.whiteColor()

        containerView.backgroundColor = UIColor.whiteColor()
        containerView.layer.cornerRadius = 4

        contentView.backgroundColor = UIColor.clearColor()

        nameLabel.font = UIFont(name: "Helvetica-Neue", size: 12)
        nameLabel.textColor = Colors.tintColor

        styleLabel.font = UIFont(name: "Helvetica-Neue", size: 10)
        styleLabel.textColor = Colors.grayFont

        ibuLabel.font = UIFont(name: "Helvetica-Neue", size: 10)
        ibuLabel.textColor = Colors.tintColor

        let layer = shadowView.layer
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 25


        contentView.addSubview(shadowView)
        contentView.addSubview(containerView)

        containerView.addSubview(nameLabel)
        containerView.addSubview(beerImage)
        containerView.addSubview(ibuLabel)
        containerView.addSubview(styleLabel)
    }

    func setName(name: String) {
        nameLabel.text = name
    }


    func setBeerImage(image: UIImage?) {
        beerImage.image = image
    }


    func setIBU(ibu: String) {
        ibuLabel.text = ibu
    }

    func setStyle(style: String) {
        styleLabel.text = style
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.frame = contentView.bounds
        containerView.centerX = contentView.centerX

        shadowView.frame = CGRect(x: 0, y: 0, width: containerView.width - 28, height: contentView.height)
        shadowView.bottom = containerView.bottom
        shadowView.centerX = contentView.centerX

        beerImage.frame = CGRect(x: 0, y: 0, width: width, height: 136)
        nameLabel.frame = CGRect(x: rigthOffset, y: beerImage.bottom + 8, width: width - rigthOffset * 2, height: 20)
        styleLabel.frame = CGRect(x: rigthOffset, y: nameLabel.bottom + 8, width: width - rigthOffset * 2, height: 20)
        ibuLabel.frame = CGRect(x: rigthOffset, y: styleLabel.bottom + 8, width: width - rigthOffset * 2, height: 20)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        beerImage.image = nil
        ibuLabel.text = nil
        styleLabel.text = nil
        nameLabel.textColor = nil
    }


}
