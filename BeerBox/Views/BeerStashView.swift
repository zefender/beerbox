//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit


protocol BeerStashViewDelegate: class {
    func beerStashView(view: BeerStashView, didSelectItemWithIndex index: Int)
}


class BeerStashView: UIView, UICollectionViewDataSource, UICollectionViewDelegate,
        UICollectionViewDelegateFlowLayout {
    weak var delegate: BeerStashViewDelegate?

    private var stash: [BeerItem]?

    private lazy var stashCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = Colors.background
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        collectionView.allowsMultipleSelection = true
        collectionView.registerClass(BeerCollectionViewCell.self, forCellWithReuseIdentifier: BeerCollectionViewCell.cellId)

        return collectionView
    }()

    private let emptyLabel = UILabel()


    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(stashCollectionView)
        addSubview(emptyLabel)

        backgroundColor = Colors.background
        
        emptyLabel.hidden = true
        emptyLabel.text = "Your stash is empty."
        emptyLabel.textAlignment = .Center
        emptyLabel.font = UIFont(name: "Helvetica", size: 24)
        emptyLabel.textColor = Colors.tintColor
    }

    func showStash(stash: [BeerItem]) {
        self.stash = stash

        stashCollectionView.reloadData()

        stashCollectionView.hidden = stash.isEmpty
        emptyLabel.hidden = !stash.isEmpty
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        stashCollectionView.frame = bounds
        emptyLabel.frame = CGRect(x: 0, y: 0, width: width, height: 44)
        emptyLabel.center = center
    }

    func setInsets(insets: UIEdgeInsets) {
        stashCollectionView.contentInset = insets
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let stash = stash {
            return stash.count
        }

        return 0
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)

        delegate?.beerStashView(self, didSelectItemWithIndex: indexPath.row)
    }


    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 126, height: 235)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)
    }


    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 24
    }


    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(BeerCollectionViewCell.cellId, forIndexPath: indexPath) as! BeerCollectionViewCell

        if let stash = stash {
            let beer = stash[indexPath.row]

            cell.setName(beer.name)
            cell.setStyle(beer.style)
            cell.setIBU("IBU: \(beer.IBU)")
            if let photo = DataManager.instance.photoForBeer(beer) {
                cell.setBeerImage(photo)
            }
        }

        return cell
    }
}
