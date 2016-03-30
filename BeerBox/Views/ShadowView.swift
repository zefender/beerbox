import Foundation
import UIKit

class ShadowView: UIView {
    private let shadowView: UIView = UIView()
    private let containerView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        shadowView.backgroundColor = UIColor.whiteColor()
        containerView.backgroundColor = UIColor.whiteColor()

        let layer = shadowView.layer
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 25

        addSubview(containerView)
        addSubview(shadowView)

        sendSubviewToBack(shadowView)
    }

    func setCornerRaduis(radius: CGFloat) {
        containerView.layer.cornerRadius = radius
    }
    
    func setBackGroundColor(color: UIColor) {
        containerView.backgroundColor = color
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.frame = bounds

        shadowView.frame = CGRect(x: 0, y: 0, width: containerView.width - 28, height: height / 2)
        shadowView.bottom = containerView.bottom
        shadowView.centerX = bounds.centerX
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView(view: UIView) {
        containerView.addSubview(view)
    }

}
