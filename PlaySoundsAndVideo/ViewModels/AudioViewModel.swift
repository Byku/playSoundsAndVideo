import AVFoundation
import Foundation
import RxSwift


class AudioListViewModel {
    
    // create new player for every added audio to mix different sounds
    public var audioList: [AudioDetailsModel] = [] {
        willSet {
            guard let url = newValue.last?.urlString,
                let audioPath = Bundle.main.path(forResource: url, ofType: "mp3"),
                let player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                else { return }
            playerList[url] = player
        }
    }
    public var playerList: [String: AVAudioPlayer] = [:]
    
    init() {
        fillModel()
    }
    
    func player(by url: String) -> AVAudioPlayer? {
        return playerList[url]
    }
    
    func player(at index: Int) -> AVAudioPlayer? {
        return player(by: audioList[index].urlString)
    }
    
    func stopAllPlayers() {
        for (_, player) in playerList {
            player.stop()
        }
    }
}

private extension AudioListViewModel {
    func fillModel() {
        audioList.append(AudioDetailsModel(labelString: "Весенняя капель", urlString: "kapel"))
        audioList.append(AudioDetailsModel(labelString: "Морские волны", urlString: "sea"))
        audioList.append(AudioDetailsModel(labelString: "Ночные цикады", urlString: "cikady"))
    }
}
