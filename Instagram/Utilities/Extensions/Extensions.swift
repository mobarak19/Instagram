
import Foundation


import UIKit

extension UIView{

    public var width:CGFloat{
        return frame.size.width
    }
    public var height:CGFloat{
        return frame.size.height
    }
    public var top:CGFloat{
        return frame.origin.y
    }
    public var left:CGFloat{
        return frame.origin.x
    }
    public var right:CGFloat{
        return frame.origin.x+frame.width
    }
    public var bottom:CGFloat{
        return frame.origin.y + frame.size.height
    }
}


extension String{
    
    func makeFirebaseDatabaseKey()->String{
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}
