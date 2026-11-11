import Combine

final class FilmDetailsViewModel: ObservableObject {
    let film = Film(
        title: "Film details",
        genre: "Drama",
        year: 2026,
        rating: 8
    )

    var detailsText: String {
        "Genre: \(film.genre)\nYear: \(film.year)\nRating: \(film.rating) / 10"
    }
}
