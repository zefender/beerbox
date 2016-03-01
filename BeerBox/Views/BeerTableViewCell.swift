//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class BeerTableViewCell: UITableViewCell {
    static let cellId = "BeerTableViewCellId"

    private let nameLabel = UILabel()
    private let descLabel = UILabel()
    private let beerImageView: UIImageView = UIImageView()

    private let shadowView: UIView = UIView()
    private let containerView: UIView = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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
        containerView.addSubview(descLabel)
        containerView.addSubview(beerImageView)
    }


    func setName(name: String) {
        nameLabel.text = name
    }

    func setDesc(desc: String) {
        descLabel.text = desc
    }

    func setBeerImage(image: UIImage) {
        beerImageView.image = image
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.frame = CGRect(x: 0, y: 0, width: contentView.width - 32, height: contentView.height - 25)
        containerView.centerX = centerX

        shadowView.frame = CGRect(x: 0, y: 0, width: containerView.width - 28, height: height / 2)
        shadowView.bottom = containerView.bottom
        shadowView.centerX = centerX

        beerImageView.frame = CGRect(x: 0, y: 0, width: 88, height: 88)
        nameLabel.frame = CGRect(x: beerImageView.right + 10, y: 6, width: containerView.width - beerImageView.width - 20, height: 44)
        descLabel.frame = CGRect(x: beerImageView.right + 10, y: nameLabel.bottom + 6, width: containerView.width - beerImageView.width - 16, height: 44)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = nil
        descLabel.text = nil
        beerImageView.image = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
