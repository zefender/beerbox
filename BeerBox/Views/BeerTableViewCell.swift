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
    private let beerImageView = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(beerImageView)
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

        beerImageView.frame = CGRect(x: 0, y: 0, width: 120, height: height)
        nameLabel.frame = CGRect(x: beerImageView.right + 8, y: 8, width: width - beerImageView.width - 16, height: 44)
        descLabel.frame = CGRect(x: beerImageView.right + 8, y: nameLabel.bottom + 4, width: width - beerImageView.width - 16, height: 44)
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
