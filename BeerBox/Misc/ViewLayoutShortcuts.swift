import UIKit

extension UIView {
    // MARK: - Basic properties
    
    final var size: CGSize  {
        @inline(__always) get { return frame.size }
        @inline(__always) set { frame.size = newValue }
    }
    final var origin: CGPoint {
        @inline(__always) get { return frame.origin }
        @inline(__always) set { frame.origin = newValue }
    }
    
    final var width: CGFloat {
        @inline(__always) get { return size.width }
        @inline(__always) set { size.width = newValue }
    }
    final var height: CGFloat {
        @inline(__always) get { return size.height }
        @inline(__always) set { size.height = newValue }
    }
    
    final var x: CGFloat {
        @inline(__always) get { return origin.x }
        @inline(__always) set { origin.x = newValue }
    }
    final var y: CGFloat {
        @inline(__always) get { return origin.y }
        @inline(__always) set { origin.y = newValue }
    }
    
    // Basic alignment:
    
    final var centerX: CGFloat {
        @inline(__always) get { return center.x }
        @inline(__always) set { x = newValue - width/2 }
    }
    final var centerY: CGFloat {
        @inline(__always) get { return center.y }
        @inline(__always) set { y = newValue - height/2 }
    }
    final var left: CGFloat {
        @inline(__always) get { return x }
        @inline(__always) set { x = newValue }
    }
    final var right: CGFloat {
        @inline(__always) get { return left + width }
        @inline(__always) set { left = newValue - width }
    }
    final var top: CGFloat {
        @inline(__always) get { return y }
        @inline(__always) set { y = newValue }
    }
    final var bottom: CGFloat {
        @inline(__always) get { return top + height }
        @inline(__always) set { top = newValue - height }
    }
}

    