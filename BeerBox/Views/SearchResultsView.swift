//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

protocol SearchResultViewDelegate: class {
    func searchResultView(view: SearchResultView, didTriggerStashActionForIndex index: Int)
}

enum FetchingViewState {
    case Loading, Normal
}

class SearchResultView: UIView, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: SearchResultViewDelegate?

    private var beersModel: [BeerItem]!
    private var photoLoader: ((String, (UIImage?) -> ()) -> ())!

    private let searchResultTableView: UITableView = UITableView()
    private let dimmedView: UIView = UIView()
    private let spinnerView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)

    var state: FetchingViewState = .Normal {
        didSet {
            switch state {
            case .Normal:
                dimmedView.fadeOut {
                    finished in
                    self.spinnerView.stopAnimating()
                }
            case .Loading:
                dimmedView.fadeIn {
                    finished in
                    self.spinnerView.startAnimating()
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        dimmedView.backgroundColor = Colors.tintColor
        dimmedView.alpha = 0

        searchResultTableView.registerClass(BeerTableViewCell.self, forCellReuseIdentifier: BeerTableViewCell.cellId)
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.backgroundColor = UIColor(red: 253 / 255, green: 253 / 255, blue: 253 / 255, alpha: 1)
        searchResultTableView.separatorStyle = .None
        searchResultTableView.allowsSelection = false

        addSubview(searchResultTableView)
        addSubview(dimmedView)
        dimmedView.addSubview(spinnerView)
    }

    func showBeers(beers: [BeerItem], photoLoader: ((String, (UIImage?) -> ()) -> ())?) {
        self.photoLoader = photoLoader
        beersModel = beers
        searchResultTableView.reloadData()
    }

    func endAddingToStash() {
        searchResultTableView.setEditing(false, animated: true)
    }

    func setInsets(insets: UIEdgeInsets) {
        searchResultTableView.contentInset = insets
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

            if beer.inStash {
                cell.setChekedImage(UIImage(named: "Check"))
            }

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
            self.delegate?.searchResultView(self, didTriggerStashActionForIndex: indexPath.row)
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

        searchResultTableView.frame = bounds
        dimmedView.frame = bounds

        spinnerView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        spinnerView.center = center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
