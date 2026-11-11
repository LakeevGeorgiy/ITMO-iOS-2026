import Combine
import Foundation

@MainActor
final class RatingViewModel: ObservableObject {
    @Published private(set) var rating: Int?
    private let defaults: UserDefaults
    private let key = "lastRandomRating"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        rating = defaults.object(forKey: key) as? Int // Read
    }

    func generateRating() {
        let newRating = Int.random(in: 1...10)
        defaults.set(newRating, forKey: key) // Create or Update
        rating = newRating
    }

    func clearRating() {
        defaults.removeObject(forKey: key) // Delete
        rating = nil
    }
}
