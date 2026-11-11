import Combine

final class RatingViewModel: ObservableObject {
    @Published private(set) var rating: Int?

    func generateRating() {
        rating = Int.random(in: 1...10)
    }
}
