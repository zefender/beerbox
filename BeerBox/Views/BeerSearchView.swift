//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

protocol BeerSearchViewDelegate: class {
    func beerSearchView(view: BeerSearchView, didSelectIndex index: Int)
}

class BeerSearchView: UIView, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: BeerSearchViewDelegate?

    private var beersModel: BeerListResponse!

    private let tableView: UITableView = UITableView()
    private let searchView: UISearchBar = UISearchBar()

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.registerClass(BeerTableViewCell.self, forCellReuseIdentifier: BeerTableViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self

        addSubview(tableView)
        addSubview(searchView)
    }

    func showBeers(beers: BeerListResponse) {
        beersModel = beers
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beersModel.beers?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BeerTableViewCell.cellId) as! BeerTableViewCell

        if let beer = beersModel.beers?[indexPath.row] {
            cell.setName(beer.name)
            cell.setDesc(beer.description)
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)

        delegate?.beerSearchView(self, didSelectIndex: indexPath.row)
    }


    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .Normal, title: "More") {
            action, index in

        }

        more.backgroundColor = UIColor.lightGrayColor()

        let favorite = UITableViewRowAction(style: .Normal, title: "Favorite") {
            action, index in

        }

        favorite.backgroundColor = UIColor.orangeColor()

        let share = UITableViewRowAction(style: .Normal, title: "Share") {
            action, index in

        }

        share.backgroundColor = UIColor.blueColor()

        return [share, favorite, more]
    }


    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        searchView.frame = CGRect(x: 0, y: 64, width: width, height: 44)
        tableView.frame = CGRect(x: 0, y: searchView.bottom, width: width, height: height - searchView.bottom)
        tableView.contentInset = UIEdgeInsetsZero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
