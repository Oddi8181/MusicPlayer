import SwiftUI

struct Song: Identifiable{
    let id = UUID()
    let title: String;
    let artist: String;
    let filename: String;
    
    static let mockSongs = [
        Song(title: "Bohemian Rhapsody", artist: "Queen", filename: "bohemian_rhapsody"),
        Song(title: "Hotel California", artist: "Eagles", filename: "hotel_california"),
        Song(title: "Stairway to Heaven", artist: "Led Zeppelin", filename: "stairway_to_heaven"),
    ]
}


func loadSongsFromBundle(folder: String = "Audio") -> [Song] {
    guard let folderURL = Bundle.main.url(forResource: folder, withExtension: nil) else {
        return []
    }
    
    let files = try? FileManager.default
        .contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
        .filter { $0.pathExtension == "mp3"}
    
    return files? .map{  url in
        let filename = url.deletingPathExtension().lastPathComponent
        return Song(title: filename, artist: "Unknown", filename: filename)
    } ?? []
    
    
}
