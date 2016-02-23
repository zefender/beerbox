import Foundation
import UIKit

extension CGRect {
    // Basic properties:
    
    var width: CGFloat {
        get { return size.width }
        set { size.width = newValue }
    }
    var height: CGFloat {
        get { return size.height }
        set { size.height = newValue }
    }
    
    var x: CGFloat {
        get { return origin.x }
        set { origin.x = newValue }
    }
    var y: CGFloat {
        get { return origin.y }
        set { origin.y = newValue }
    }
    
    // Basic alignment:
    
    var center: CGPoint {
        get {
            return CGPointMake(centerX, centerY)
        }
        set {
            centerX = newValue.x
            centerY = newValue.y
        }
    }
    
    var centerX: CGFloat {
        get { return x + width/2 }
        set { x = newValue - width/2 }
    }
    var centerY: CGFloat {
        get { return y + height/2 }
        set { y = newValue - height/2 }
    }
    var left: CGFloat {
        get { return x }
        set { x = newValue }
    }
    var right: CGFloat {
        get { return left + width }
        set { left = newValue - width }
    }
    var top: CGFloat {
        get { return y }
        set { y = newValue }
    }
    var bottom: CGFloat {
        get { return top + height }
        set { top = newValue - height }
    }
    
   init(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) {
        self.init(x: left, y: top, width: right - left, height: bottom - top)
    }
    
}