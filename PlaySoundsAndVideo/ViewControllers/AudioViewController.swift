import AVFoundation
import UIKit
import Reusable
import RxCocoa
import RxSwift

enum PlayerState {
    case playing
    case paused
    
    var buttonTitle: String {
        switch self {
        case .playing:
            return "Play"
        case .paused:
            return "Pause"
        }
    }
    
    mutating func toggle() {
        switch self {
        case .playing:
            self = .paused
        case .paused:
            self = .playing
        }
    }
}

class AudioViewController: UIViewController {

    @IBOutlet var audioCollectionView: UICollectionView!
    
    private var audioViewModel = AudioListViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioCollectionView.dataSource = self
        audioCollectionView.register(cellType: AudioCollectionViewCell.self)
    }
    
    func stopAllSounds() {
        audioViewModel.stopAllPlayers()
        updateButtonTitles()
    }
    
    private func updateButtonTitles() {
        // todo update buttons when players stops from another tab
    }
}

extension AudioViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return audioViewModel.audioList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AudioCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let player = audioViewModel.player(at: indexPath.row) else { return cell }
        player.prepareToPlay()
        
        cell.label.text = audioViewModel.audioList[indexPath.row].labelString
        cell.button.rx.tap
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                switch cell.playerState {
                case .paused:
                    player.play()
                    if let customTabBarController = self.tabBarController as? CustomTabBarController {
                        customTabBarController.isAudioPlaying.onNext(true)
                        cell.showLine()
                    }
                case .playing:
                    player.stop()
                    cell.hideLine()
                }
                cell.button.setTitle(cell.playerState.buttonTitle, for: .normal)
                cell.playerState.toggle()
            })
            .disposed(by: disposeBag)
        
        return cell
    }
}
