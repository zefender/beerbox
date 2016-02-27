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
        collectionView.backgroundColor = UIColor.blackColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        collectionView.allowsMultipleSelection = true
        collectionView.registerClass(BeerCollectionViewCell.self, forCellWithReuseIdentifier: BeerCollectionViewCell.cellId)

        return collectionView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(stashCollectionView)
    }

    func showStash(stash: [BeerItem]) {
        self.stash = stash

        stashCollectionView.reloadData()
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        stashCollectionView.frame = bounds
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
        return CGSize(width: 160, height: 230)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }


    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(BeerCollectionViewCell.cellId, forIndexPath: indexPath) as! BeerCollectionViewCell

        if let stash = stash {
            let beer = stash[indexPath.row]

            cell.setName(beer.name)
            cell.setStyle(beer.style)
        }

        return cell
    }
}
