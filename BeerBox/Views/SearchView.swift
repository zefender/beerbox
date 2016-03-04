import Foundation
import UIKit

protocol SearchViewDelegate: class {
    func searchViewDidTriggerCloseAction(view: SearchView)
}

class SearchView: UIView, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: SearchViewDelegate?

    private let onePixel = 1 / UIScreen.mainScreen().scale

    private let searchTextFeild: TextFeild = TextFeild()
    private let tableView: UITableView = UITableView()
    private let closeButton: UIButton = UIButton()
    private let border: CALayer = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        searchTextFeild.backgroundColor = UIColor.whiteColor()
        searchTextFeild.placeholder = "Type beer name"

        addBorder()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None

        closeButton.addTarget(self, action: "closeButtonDidTapped:", forControlEvents: .TouchUpInside)
        closeButton.setTitle("X", forState: .Normal)
        closeButton.backgroundColor = UIColor.whiteColor()
        closeButton.setTitleColor(UIColor.blackColor(), forState: .Normal)

        addSubview(searchTextFeild)
        addSubview(tableView)
        addSubview(closeButton)
    }

    private func addBorder() {
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.borderWidth = onePixel
        tableView.layer.addSublayer(border)
        tableView.layer.masksToBounds = true
    }

    func closeButtonDidTapped(sender: UIButton) {
        delegate?.searchViewDidTriggerCloseAction(self)
    }

    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        searchTextFeild.frame = CGRect(x: 0, y: 0, width: width - 44, height: 56)
        closeButton.frame = CGRect(x: searchTextFeild.right, y: 0, width: 44, height: 56)
        tableView.frame = CGRect(x: 0, y: searchTextFeild.bottom, width: width, height: height - searchTextFeild.height)
        border.frame = CGRect(x: 0, y: 0, width: width, height: onePixel)
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
