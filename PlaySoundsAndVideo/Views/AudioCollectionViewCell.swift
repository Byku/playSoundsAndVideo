import UIKit
import Reusable

class AudioCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet private var lineLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var lineTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var line: UIView!
    
    var playerState: PlayerState = .paused
    
    func showLine() {
        lineLeadingConstraint.constant = 0
        lineTrailingConstraint.constant = frame.width
        layoutIfNeeded()
        line.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.lineLeadingConstraint.constant = self.frame.width * 0.2
            self.lineTrailingConstraint.constant = 20
            self.layoutIfNeeded()
        }
    }
    
    func hideLine() {
        UIView.animate(withDuration: 0.3) {
            self.lineLeadingConstraint.constant = self.frame.width
            self.lineTrailingConstraint.constant = 0
            self.layoutIfNeeded()
        }
    }
}
