import Foundation
import UIKit


protocol BreweryButtonDelegate: class {
    func breweryButtonDidTapped(view: BreweryButton)
}

class BreweryButton: UIView {
    weak var delegate: BreweryButtonDelegate?

    private let nameLabel: UILabel = UILabel()
    private let countryLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
//    private let touchView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel.font = UIFont(name: "Helvetica", size: 13)
        titleLabel.textColor = Colors.orangeFont

        countryLabel.font = UIFont(name: "Helvetica", size: 13)
        countryLabel.textColor = Colors.grayFont

        nameLabel.font = UIFont(name: "Helvetica", size: 15)
        nameLabel.textColor = Colors.tintColor

        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: "onTap:")
        addGestureRecognizer(recognizer)


        addSubview(nameLabel)
        addSubview(countryLabel)
        addSubview(titleLabel)
//        addSubview(touchView)

//        bringSubviewToFront(touchView)
    }

    func setTitle(title: String) {
        titleLabel.text = title
    }

    func setCountryTitle(title: String) {
        countryLabel.text = title
    }

    func setNameTitle(title: String) {
        nameLabel.text = title
    }

    func onTap(sender: AnyObject) {
        delegate?.breweryButtonDidTapped(self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.frame = CGRect(x: 17, y: 10, width: 100, height: 0)
        titleLabel.sizeToFit()

        countryLabel.frame = CGRect(x: 0, y: 10, width: 100, height: 0)
        countryLabel.sizeToFit()
        countryLabel.right = bounds.width - 17

        nameLabel.frame = CGRect(x: 17, y: titleLabel.bottom + 10, width: width - 34, height: 0)
        nameLabel.sizeToFit()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
