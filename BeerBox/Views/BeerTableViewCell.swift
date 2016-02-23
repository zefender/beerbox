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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
    }


    func setName(name: String) {
        nameLabel.text = name
    }

    func setDesc(desc: String) {
        descLabel.text = desc
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        nameLabel.frame = CGRect(x: 0, y: 0, width: width / 2, height: height)
        descLabel.frame = CGRect(x: nameLabel.right, y: 0, width: width / 2, height: height)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = nil
        descLabel.text = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
