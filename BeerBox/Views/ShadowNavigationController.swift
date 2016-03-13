import Foundation
import UIKit

class ShadowNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        let shadowLayer = navigationBar.layer
        shadowLayer.shadowColor = UIColor.blackColor().CGColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 20
    }

    override func shouldAutorotate() -> Bool {
        return false
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
