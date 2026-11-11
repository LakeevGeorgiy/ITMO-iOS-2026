import Combine
import Foundation
import SwiftData

@MainActor
final class FilmDetailsViewModel: ObservableObject {
    @Published private(set) var films: [Film] = []
    @Published var errorMessage: String?
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
        context.autosaveEnabled = false
        loadFilms()
    }

    func loadFilms() {
        do {
            films = try context.fetch(FetchDescriptor<Film>(sortBy: [SortDescriptor(\Film.title)]))
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func addFilm(title: String, genre: String, year: Int, rating: Int) -> Bool {
        guard validate(title: title) else { return false }
        context.insert(Film(title: title, genre: genre, year: year, rating: rating))
        return saveChanges()
    }

    func updateFilm(_ film: Film, title: String, genre: String, year: Int, rating: Int) -> Bool {
        guard validate(title: title) else { return false }
        film.title = title
        film.genre = genre
        film.year = year
        film.rating = rating
        return saveChanges()
    }

    func deleteFilm(_ film: Film) {
        context.delete(film)
        _ = saveChanges()
    }

    private func validate(title: String) -> Bool {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Enter a film title."
            return false
        }
        return true
    }

    private func saveChanges() -> Bool {
        do {
            try context.save()
            loadFilms()
            return true
        } catch {
            context.rollback()
            errorMessage = error.localizedDescription
            return false
        }
    }
}
