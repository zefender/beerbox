import Foundation
import UIKit


protocol SearchViewDelegate: class {
    func searchViewDidTriggerCloseAction(view: SearchView)
}

class SearchView: UIView {
    weak var delegate: SearchViewDelegate?

    private let searchTextField: UITextField = UITextField()
    private let closeButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        closeButton.setTitle("X", forState: .Normal)
        closeButton.addTarget(self, action: "closeButtonDidTaped:", forControlEvents: .TouchUpInside)

        addSubview(searchTextField)
        addSubview(closeButton)
    }

    func setPlaceHolder(placeholder: String) {
        searchTextField.placeholder = placeholder
    }

    func setFirstResponder() {
        searchTextField.becomeFirstResponder()
    }

    func closeButtonDidTaped(sender: AnyObject) {
        delegate?.searchViewDidTriggerCloseAction(self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        searchTextField.frame = CGRect(x: 0, y: 0, width: width - 44, height: height)
        closeButton.frame = CGRect(x: searchTextField.right, y: 0, width: height, height: height)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
