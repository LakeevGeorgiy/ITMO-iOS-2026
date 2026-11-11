import SwiftUI
import SwiftData

@main
struct FilmsApp: App {
    var body: some Scene {
        WindowGroup {
            RatingView()
        }
        .modelContainer(for: Film.self)
    }
}
