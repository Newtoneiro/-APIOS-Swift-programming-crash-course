//
//  Created by Bartosz Latosek on 17/05/2023.
//  Last changes 17/05/2023.
//
//

import Cocoa

class Dziura: NSImageView {

    convenience init(dziuraImage: NSImage, superView:NSView){
        self.init()

        superView.addSubview(self)
        wantsLayer = true

        image = dziuraImage

        frame.size.width = superView.frame.size.width * 1.5
        print(frame.size.width)
        frame.size.height = superView.frame.size.height * 1.5
        print(frame.size.height)
        
        frame.origin.x = 0
        frame.origin.y = 0
        
        self.layer?.anchorPoint = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
    }

    func spin(){
        NSAnimationContext.current.duration = 10.0
        NSAnimationContext.current.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        NSAnimationContext.runAnimationGroup(
            { (NSAnimationContext) in
                let rotate = CABasicAnimation(keyPath: "transform.rotation")
                rotate.fromValue = 0
                rotate.toValue = CGFloat(-1 * .pi * 2.0)
                rotate.duration = 6
                rotate.repeatCount = .infinity
                self.layer?.add(rotate, forKey: "rotation")
            },
            completionHandler: { self.removeFromSuperview() }
        )
    }
}

