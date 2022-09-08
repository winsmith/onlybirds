import Foundation
import CoreData

class BirdNameUpdater {
    let urls = [
        "German": URL(string: "https://github.com/winsmith/birdy/raw/main/birdnames/german.txt")!,
    ]
    
    let context: NSManagedObjectContext
    
    init(with context: NSManagedObjectContext) {
        self.context = context
    }
    
    /// Remove all birds from the database
    func clearDataBase() {
        
    }
    
    func insertBirds(from url: URL) async throws {
        let fileContents = try await downloadFile(from: url)
        let birdNames = fileContents.split(separator: "\n").map { String($0) }
        
        for birdName in birdNames {
            let bird = Bird(context: context)
            bird.canonicalName = birdName
        }
        
        try context.save()
    }
    
    func downloadFile(from url: URL) async throws -> String {
        let (urlData, _) = try await URLSession.shared.data(from: url)
        
        guard let fileString = String(data: urlData, encoding: .utf8) else {
            throw URLError(.badServerResponse)
        }
        
        return fileString
    }
}
