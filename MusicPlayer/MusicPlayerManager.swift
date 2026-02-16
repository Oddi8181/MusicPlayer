import  Foundation
import AVFoundation
internal import Combine

final class MusicPlayerManager : ObservableObject {
    
    @Published private(set) var isPlaying: Bool = false;
    @Published private(set) var duration: TimeInterval = 0.0;
    @Published private(set) var currentTime: TimeInterval = 0.0;
    
    
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    func loadBundledFile(named name: String, ext: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            print("File not found \(name).\(ext)")
            return
        }
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            duration = player?.duration ?? 0
            currentTime = 0
        }catch{
            print("Failed to load audio \(error)")
        }
    }
    
    func play(){
        guard let player else {return}
        player.play()
        isPlaying = true
        startTimer()
    }
    
    func pause(){
        player?.pause()
        isPlaying = false
        stopTimer()
    }
    
    func stop(){
        player?.stop()
        player?.currentTime = 0
        currentTime = 0
        isPlaying = false
        stopTimer()
    }
    
    func seek(to time: TimeInterval){
        guard let player else {return}
        player.currentTime = time
        currentTime = time
    }
    
    private func startTimer(){
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true){
            [weak self] _ in guard let self, let player = self.player else {return}
            self.currentTime = player.currentTime
            self.duration = player.duration
            if !player.isPlaying{
                self.isPlaying = false
                self.stopTimer()
            }
        }
    }
    
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
}
