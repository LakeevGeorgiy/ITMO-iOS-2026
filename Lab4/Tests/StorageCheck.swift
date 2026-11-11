import Foundation
import SwiftData

@main
@MainActor
struct StorageCheck {
    static func main() throws {
        let directory = FileManager.default.temporaryDirectory
            .appendingPathComponent("FilmsCheck-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        let url = directory.appendingPathComponent("films.store")

        // Reopen the disk database for each step to check persistence.
        try withViewModel(at: url) { model in
            try expect(model.addFilm(title: "Arrival", genre: "Drama", year: 2016, rating: 8))
        }
        try withViewModel(at: url) { model in
            try expect(model.films.count == 1)
            let film = model.films[0]
            try expect(film.title == "Arrival" && film.rating == 8)
            try expect(!model.updateFilm(film, title: " ", genre: "Drama", year: 2016, rating: 9))
            try expect(film.title == "Arrival")
            try expect(model.updateFilm(film, title: "Arrival edited", genre: "Sci-fi", year: 2016, rating: 9))
        }
        try withViewModel(at: url) { model in
            try expect(model.films[0].title == "Arrival edited" && model.films[0].rating == 9)
            model.deleteFilm(model.films[0])
            try expect(model.errorMessage == nil)
        }
        try withViewModel(at: url) { model in
            try expect(model.films.isEmpty)
        }

        let suite = "Films.StorageCheck.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suite)!
        defer { defaults.removePersistentDomain(forName: suite) }
        let ratingModel = RatingViewModel(defaults: defaults)
        try expect(ratingModel.rating == nil)
        ratingModel.generateRating()
        let restored = RatingViewModel(defaults: UserDefaults(suiteName: suite)!)
        try expect(restored.rating == ratingModel.rating)
        restored.generateRating()
        try expect(RatingViewModel(defaults: defaults).rating == restored.rating)
        restored.clearRating()
        try expect(RatingViewModel(defaults: defaults).rating == nil)

        print("PASS: SwiftData CRUD persists; UserDefaults creates, reads, updates and deletes the rating.")
    }

    private static func withViewModel(at url: URL, check: (FilmDetailsViewModel) throws -> Void) throws {
        let container = try ModelContainer(for: Film.self, configurations: ModelConfiguration(url: url))
        let model = FilmDetailsViewModel(context: ModelContext(container))
        try expect(model.errorMessage == nil)
        try check(model)
    }

    private static func expect(_ condition: Bool) throws {
        guard condition else { throw CheckFailed() }
    }
}

struct CheckFailed: Error { }
