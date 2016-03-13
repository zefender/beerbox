import Foundation
import UIKit


protocol SearchViewDelegate: class {
    func searchViewDidTriggerCloseAction(view: SearchView)
}

class SearchView: UIView, UITextFieldDelegate {
    weak var delegate: SearchViewDelegate?

    private let searchTextField: UITextField = UITextField()
    private let closeButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        closeButton.setTitle("cancel", forState: .Normal)
        closeButton.addTarget(self, action: "closeButtonDidTaped:", forControlEvents: .TouchUpInside)
        closeButton.backgroundColor = Colors.tintColor
        closeButton.layer.cornerRadius = 4
        closeButton.titleLabel!.font = UIFont(name: "Helvetica", size: 12)

        searchTextField.delegate = self
        searchTextField.returnKeyType = .Search

        addSubview(searchTextField)
        addSubview(closeButton)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

        searchTextField.frame = CGRect(x: 0, y: 0, width: width - 99, height: height)
        closeButton.frame = CGRect(x: searchTextField.right + 16, y: 0, width: 51, height: 24)
        closeButton.centerY = centerY
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
