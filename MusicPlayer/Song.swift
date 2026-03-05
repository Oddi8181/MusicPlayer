import SwiftUI

struct Song{
    let title: String;
    let artist: String;
    let filename: String;
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
