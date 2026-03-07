import SwiftUI

struct PlayerView: View{
    @ObservedObject var audio: MusicPlayerManager
    @State private var isSeeking: Bool = false
    @State private var sliderValue: Double = 0.0
    
    var body: some View {
        VStack(spacing: 20){
            Text(audio.currentSong?.title ?? "No song selected")
                .font(.largeTitle).bold()
            
            Text(audio.currentSong?.artist ?? "")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
      
            VStack{
                Slider(
                    value: Binding(
                        get: {isSeeking ? sliderValue : audio.currentTime},
                        set: {newValue in sliderValue = newValue}
                        ),
                    in: 0...(max(audio.duration, 0.01)),
                    onEditingChanged: { editing in
                        isSeeking = editing
                        if !editing {
                            audio.seek(to: sliderValue) }
                    }
                    )
                    HStack{
                        Text(formatTime(audio.currentTime))
                        Spacer()
                        Text(formatTime(audio.duration))
                    }
                    .font(.caption)
                    .monospacedDigit()
            }
            HStack(spacing: 16){
                Button("Play") {audio.play()}
                    .buttonStyle(.borderedProminent)
                Button("Pause") {audio.pause()}
                    .buttonStyle(.bordered)
                Button("Stop") {audio.stop()}
                    .buttonStyle(.bordered)
                
            }
            Text(audio .isPlaying ? "Playing" : "Paused/Stopped")
                .foregroundStyle(audio.isPlaying ? .green : .secondary)
            
            Spacer()
        }
        .padding()
    }
    private func formatTime(_ t: TimeInterval) -> String {
        let totalSeconds = Int(t)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
