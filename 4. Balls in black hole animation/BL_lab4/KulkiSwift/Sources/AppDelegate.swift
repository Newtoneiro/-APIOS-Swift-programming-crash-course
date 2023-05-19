//
//  Created by Bartosz Latosek on 17/05/2023.
//  Last changes 17/05/2023.
//
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	@IBOutlet weak var fallingView: FallingView!
    
    func applicationDidBecomeActive(_ notification: Notification) {
        createBall()
    }
    
    func createBall() {
        var name:NSImage.Name
        switch Int.random(in: 1...7){
            case 1: name = "Baseball"
            case 2: name = "Basketball"
            case 3: name = "Billiardball"
            case 4: name = "Football"
            case 5: name = "Golfball"
            case 6: name = "Tennisball"
            default: name = "Volleyball"
        }
        let image = NSImage(named: name)!
        let diameter = Int.random(in: 20...150)
        image.size = NSSize(width: diameter, height: diameter)
        let pilka = Pilka(ballImage: image, superView:fallingView)
        let duration = Double.random(in: 2.0...10.0)
        pilka.falling(duration)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.createBall()
        }
    }
}
