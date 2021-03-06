//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class BeerTableViewCell: UITableViewCell {
    static let cellId = "BeerTableViewCellId"

    private let nameLabel = UILabel()
    private let styleLabel = UILabel()
    private let ibuLabel = UILabel()
    private let beerImageView: UIImageView = UIImageView()
    private let checkedImageView = UIImageView()

    private let shadowView: UIView = UIView()
    private let containerView: UIView = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nameLabel.font = UIFont(name: "Helvetica-Neue", size: 15)
        nameLabel.textColor = Colors.tintColor

        styleLabel.font = UIFont(name: "Helvetica-Neue", size: 13)
        styleLabel.textColor = Colors.grayFont

        ibuLabel.font = UIFont(name: "Helvetica-Neue", size: 15)
        ibuLabel.textColor = Colors.tintColor

        contentView.backgroundColor = UIColor.clearColor()
        backgroundColor = UIColor.clearColor()
        shadowView.backgroundColor = UIColor.whiteColor()

        containerView.backgroundColor = UIColor.whiteColor()
        containerView.layer.cornerRadius = 4

        let layer = shadowView.layer
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 25

        beerImageView.contentMode = .ScaleAspectFill

        contentView.addSubview(shadowView)
        contentView.addSubview(containerView)

        containerView.addSubview(nameLabel)
        containerView.addSubview(styleLabel)
        containerView.addSubview(beerImageView)
        containerView.addSubview(ibuLabel)
        containerView.addSubview(checkedImageView)
    }


    func setName(name: String) {
        nameLabel.text = name
    }

    func setStyle(style: String) {
        styleLabel.text = style
    }

    func setBeerImage(image: UIImage) {
        beerImageView.image = image
    }

    func setChekedImage(image: UIImage?) {
        checkedImageView.image = image
    }

    func setIBU(ibu: String) {
        ibuLabel.text = "IBU: \(ibu)"
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.frame = CGRect(x: 0, y: 0, width: contentView.width - 32, height: contentView.height - 25)
        containerView.centerX = centerX

        shadowView.frame = CGRect(x: 0, y: 0, width: containerView.width - 28, height: height / 2)
        shadowView.bottom = containerView.bottom
        shadowView.centerX = centerX

        beerImageView.frame = CGRect(x: 0, y: 0, width: 88, height: 88)

        checkedImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)

        let labelsWidth = containerView.width - beerImageView.right - 20

        nameLabel.frame = CGRect(x: beerImageView.right + 10, y: 6, width: labelsWidth, height: 20)

        styleLabel.frame = CGRect(x: beerImageView.right + 10, y: nameLabel.bottom + 6, width: labelsWidth, height: 20)

        ibuLabel.frame = CGRect(x: beerImageView.right + 10, y: styleLabel.bottom + 6, width: labelsWidth, height: 20)

        for view in subviews {
            let className = NSStringFromClass(view.dynamicType)
            if className == "UITableViewCellDeleteConfirmationView" {
                view.height = height - 25
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = nil
        styleLabel.text = nil
        ibuLabel.text = nil
        beerImageView.image = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
