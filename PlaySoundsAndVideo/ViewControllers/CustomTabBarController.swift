import UIKit
import RxSwift

class CustomTabBarController: UITabBarController {
    var isAudioPlaying = BehaviorSubject<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        isAudioPlaying
            .asObservable()
            .skip(1)
            .distinctUntilChanged()
            .filter { $0 == false }
            .subscribe { _ in
                self.stopAllSounds()
            }
            .disposed(by: disposeBag)
    }
    
    func stopAllSounds() {
        guard let viewControllers = viewControllers else { return }
        for viewController in viewControllers {
            if viewController is AudioViewController {
                (viewController as! AudioViewController).stopAllSounds()
            }
        }
    }
}
