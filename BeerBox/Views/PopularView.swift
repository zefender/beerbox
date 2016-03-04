//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

protocol PopularViewDelegate: class {
    func popularView(view: PopularView, didTriggerStachActionForIndex index: Int)
}

class PopularView: UIView, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: PopularViewDelegate?

    private var beersModel: [BeerItem]!
    private var photoLoader: ((String, (UIImage?) -> ()) -> ())!

    private let tableView: UITableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.registerClass(BeerTableViewCell.self, forCellReuseIdentifier: BeerTableViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 253 / 255, green: 253 / 255, blue: 253 / 255, alpha: 1)
        tableView.separatorStyle = .None

        addSubview(tableView)
    }

    func showBeers(beers: [BeerItem], photoLoader: (String, (UIImage?) -> ()) -> ()) {
        self.photoLoader = photoLoader
        beersModel = beers
        tableView.reloadData()
    }

    func setInsets(insets: UIEdgeInsets) {
        tableView.contentInset = insets
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
        let addToStash = UITableViewRowAction(style: .Normal, title: "I'v got it!") {
            action, index in
            self.delegate?.popularView(self, didTriggerStachActionForIndex: indexPath.row)
            self.tableView.setEditing(false, animated: true)
        }

        addToStash.backgroundColor = UIColor.orangeColor()

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

        tableView.frame = bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
