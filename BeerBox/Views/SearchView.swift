import Foundation
import UIKit

class SearchView: UIView {
    private let iconImageView = UIView()
    private let textField = UITextField()

    var placeHolderText: String? {
        set {
            textField.placeholder = placeHolderText
        }
        get {
            return textField.placeholder
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(iconImageView)
        addSubview(textField)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        iconImageView.frame = CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height)
        textField.frame = CGRect(x: iconImageView.bounds.width, y: 0, width: bounds.width - iconImageView.bounds.width, height: bounds.height)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}