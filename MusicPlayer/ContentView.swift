import SwiftUI

struct ContentView: View {
    @StateObject private var audio = MusicPlayerManager()
    
    var body: some View {
        NavigationStack {
            List(audio.songs) { song in
                NavigationLink(destination: PlayerView(audio: audio)) {
                    VStack(alignment: .leading) {
                        Text(song.title)
                            .font(.headline)
                        Text(song.artist)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    audio.loadAndPlay(song: song)
                })
            }
            .navigationTitle("Songs")
            .onAppear {
                audio.loadSongs()
            }
        }
    }
}

#Preview {
    ContentView()
}
