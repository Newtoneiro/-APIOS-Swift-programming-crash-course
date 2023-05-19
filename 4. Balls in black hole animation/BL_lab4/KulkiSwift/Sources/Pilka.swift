//
//  Created by Bartosz Latosek on 17/05/2023.
//  Last changes 17/05/2023.
//
//

import Cocoa

class Pilka: NSImageView {

    let offset = CGFloat(50);
	var destination = CGPoint(x:0, y: 0)

	convenience init(ballImage theImage:NSImage, superView:NSView ){
		self.init()

		superView.addSubview(self)
		wantsLayer = true

		image = theImage

		frame.size.width = theImage.size.width
		frame.size.height = theImage.size.height
        
        var x: CGFloat
        var y: CGFloat
        switch Int.random(in: 1...4){
            case 1: x = CGFloat.random(in: 0.0...(superView.frame.size.width - frame.size.width))
                    y = -offset
            case 2: x = superView.frame.size.width + offset;
                    y = CGFloat.random(in: 0.0...(superView.frame.size.height))
            case 3: x = CGFloat.random(in: 0.0...(superView.frame.size.width - frame.size.width));
                    y = superView.frame.size.height + offset
            case 4: x = -offset;
                    y = CGFloat.random(in: 0.0...(superView.frame.size.height))
            default:x = 0;
                    y = 0;
        }
		frame.origin.y = y
        frame.origin.x = x
        
        self.layer?.anchorPoint = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
		destination = CGPoint(x: (superView.frame.size.width)/2,
                              y: (superView.frame.size.height - frame.size.height)/2)
    }

	func falling(_ sekundy: Double){
		NSAnimationContext.current.duration = sekundy
        // Określenie "sposobu upływu czasu"
        NSAnimationContext.current.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		
		NSAnimationContext.runAnimationGroup(
			{ (NSAnimationContext) in
				self.animator().frame.origin = destination
                let rotate = CABasicAnimation(keyPath: "transform.rotation")
                rotate.fromValue = 0
                rotate.toValue = CGFloat(-1 * .pi * 2.0)
                rotate.duration = sekundy
                self.layer?.add(rotate, forKey: "rotation")
                let scale = CABasicAnimation(keyPath: "transform.scale")
                scale.fromValue = 1.0
                scale.toValue = 0.2
                scale.duration = sekundy
                self.layer?.add(scale, forKey: "scale")
			},
			completionHandler: { self.removeFromSuperview() }
		)
	}
}

