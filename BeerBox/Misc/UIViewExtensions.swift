import Foundation
import UIKit

extension UIView {
    func fadeIn(duration: NSTimeInterval = 0.3, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = {
        (finished: Bool) -> Void in }) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 0.5
        }, completion: completion)
    }

    func fadeOut(duration: NSTimeInterval = 0.3, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {
        (finished: Bool) -> Void in }) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}