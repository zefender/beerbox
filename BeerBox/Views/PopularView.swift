//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

protocol PopularViewDelegate: class {
    func popularView(view: PopularView, didTriggerStashActionForIndex index: Int)
}

class PopularView: UIView, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: PopularViewDelegate?

    private var beersModel: [BeerItem]!
    private var photoLoader: ((String, (UIImage?) -> ()) -> ())!

    private let popularTableView: UITableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        popularTableView.registerClass(BeerTableViewCell.self, forCellReuseIdentifier: BeerTableViewCell.cellId)
        popularTableView.delegate = self
        popularTableView.dataSource = self
        popularTableView.backgroundColor = UIColor(red: 253 / 255, green: 253 / 255, blue: 253 / 255, alpha: 1)
        popularTableView.separatorStyle = .None

        addSubview(popularTableView)
    }

    func showBeers(beers: [BeerItem], photoLoader: ((String, (UIImage?) -> ()) -> ())?) {
        self.photoLoader = photoLoader
        beersModel = beers
        popularTableView.reloadData()
    }

    func setInsets(insets: UIEdgeInsets) {
        popularTableView.contentInset = insets
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beersModel?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BeerTableViewCell.cellId) as! BeerTableViewCell

        if let beer = beersModel?[indexPath.row] {
            cell.setName(beer.name)
            cell.setStyle(beer.style)
            cell.setIBU(String(beer.IBU))

            photoLoader(beer.labelImageUrl) {
                (image) in
                if let image = image {
                    cell.setBeerImage(image)
                }
            }
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let addToStash = UITableViewRowAction(style: .Normal, title: "I have it!") {
            action, index in
            self.delegate?.popularView(self, didTriggerStashActionForIndex: indexPath.row)
            self.popularTableView.setEditing(false, animated: true)
        }

        addToStash.backgroundColor = Colors.tintColor

        return [addToStash]
    }


    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 113
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        popularTableView.frame = bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
