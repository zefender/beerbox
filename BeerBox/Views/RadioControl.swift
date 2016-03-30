import Foundation
import UIKit

protocol RadioControlDelegate: class {
    func radioControlDidSelectIndex(index: Int)
}

class RadioControl: UIView {
    weak var delegate: RadioControlDelegate?
    
    private let titleLabel = UILabel()
    private let segmentControl = UISegmentedControl()
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    func setSegments(segments: [String]) {
        for segment in segments {
            segmentControl.insertSegmentWithTitle(segment, atIndex: segmentControl.numberOfSegments, animated: false)
        }
    }
    
    func selectIndex(index: Int) {
        segmentControl.selectedSegmentIndex = index
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.font = UIFont(name: "Helvetica", size: 17)
        titleLabel.textColor = Colors.orangeFont
        
        segmentControl.tintColor = Colors.tintColor
        segmentControl.addTarget(self, action: "segmentDidChange:", forControlEvents: .ValueChanged)
        
        addSubview(titleLabel)
        addSubview(segmentControl)
    }
    
    func segmentDidChange(sender: AnyObject) {
        delegate?.radioControlDidSelectIndex(segmentControl.selectedSegmentIndex)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        segmentControl.frame = CGRect(x: 0, y: 0, width: 100, height: 22)
        segmentControl.sizeToFit()
        segmentControl.right = bounds.right - 16
        segmentControl.centerY = bounds.centerY
        
        titleLabel.frame = CGRect(x: 16, y: 0, width: bounds.width - segmentControl.left - 16, height: 20)
        titleLabel.sizeToFit()
        titleLabel.centerY = bounds.centerY
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
