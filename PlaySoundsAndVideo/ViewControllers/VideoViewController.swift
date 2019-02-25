import UIKit

class VideoViewController: UIViewController {
    
    @IBOutlet private var watchVideoButton: UIButton!
    @IBOutlet private var videoPlaceholderLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if watchVideoButton.isHidden {
            watchVideoButton.isHidden = false
            videoPlaceholderLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        //todo prepare video
    }
    
    @IBAction func showVideoButtonTapped(_ sender: UIButton) {
        sender.isHidden = true
        guard let customTabBarController = tabBarController as? CustomTabBarController else { return }
        customTabBarController.isAudioPlaying.onNext(false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            self?.videoPlaceholderLabel.isHidden = false
        })
    }
}
