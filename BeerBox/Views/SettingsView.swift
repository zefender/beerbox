import Foundation
import UIKit

protocol SettingsViewDelegate: class {
    func settingsViewDidSelectSortTypeIndex(index: Int)
}

class SettingsView: UIScrollView, RadioControlDelegate {
    weak var settingsDelegate: SettingsViewDelegate?
    
    private let sortByRadioControl = RadioControl()
    private let sortContainer = ShadowView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.background
        
        alwaysBounceVertical = true
        
        sortByRadioControl.title = "Sort by"
        sortByRadioControl.delegate = self
        
        
        addSubview(sortContainer)
        sortContainer.addView(sortByRadioControl)
    }
    
    func showSortTypes(types: [String]) {
        sortByRadioControl.setSegments(types)
    }
    
    func selectSortType(index: Int) {
        sortByRadioControl.selectIndex(index)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func radioControlDidSelectIndex(index: Int) {
        settingsDelegate?.settingsViewDidSelectSortTypeIndex(index)
    }
    
    func setInsets(insets: UIEdgeInsets) {
        contentInset = insets
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sortContainer.frame = CGRect(x: 16, y: 0, width: width - 32, height: 44)
        sortByRadioControl.frame = sortContainer.bounds
    }
}
