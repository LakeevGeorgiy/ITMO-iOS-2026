import SwiftData

@Model
final class Film {
    var title: String
    var genre: String
    var year: Int
    var rating: Int

    init(title: String, genre: String, year: Int, rating: Int) {
        self.title = title
        self.genre = genre
        self.year = year
        self.rating = rating
    }
}
