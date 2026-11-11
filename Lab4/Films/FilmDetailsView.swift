import SwiftUI
import SwiftData

struct FilmDetailsView: View {
    @StateObject private var viewModel: FilmDetailsViewModel
    @State private var showingForm = false
    @State private var editingFilm: Film?
    @State private var title = ""
    @State private var genre = ""
    @State private var year = 2026
    @State private var rating = 5

    init(context: ModelContext) {
        _viewModel = StateObject(wrappedValue: FilmDetailsViewModel(context: context))
    }

    var body: some View {
        List {
            if let error = viewModel.errorMessage {
                Text(error).foregroundStyle(.red)
            }
            if viewModel.films.isEmpty {
                Text("No saved films. Tap + to add one.")
                    .foregroundStyle(.secondary)
            }
            ForEach(viewModel.films) { film in
                Button {
                    openForm(for: film)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(film.title).font(.headline)
                        Text("\(film.genre) · \(String(film.year)) · \(film.rating) / 10")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .onDelete { offsets in
                let selectedFilms = offsets.map { viewModel.films[$0] }
                selectedFilms.forEach(viewModel.deleteFilm)
            }
        }
        .navigationTitle("My films")
        .toolbar {
            Button("Add film", systemImage: "plus") { openForm(for: nil) }
        }
        .sheet(isPresented: $showingForm) {
            NavigationStack {
                Form {
                    TextField("Title", text: $title)
                    TextField("Genre", text: $genre)
                    Stepper("Year: \(String(year))", value: $year, in: 1888...2100)
                    Stepper("Rating: \(rating) / 10", value: $rating, in: 1...10)
                    if let error = viewModel.errorMessage {
                        Text(error).foregroundStyle(.red)
                    }
                }
                .navigationTitle(editingFilm == nil ? "Add film" : "Edit film")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { showingForm = false }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save", action: saveFilm)
                    }
                }
            }
        }
    }

    private func openForm(for film: Film?) {
        editingFilm = film
        title = film?.title ?? ""
        genre = film?.genre ?? ""
        year = film?.year ?? 2026
        rating = film?.rating ?? 5
        viewModel.errorMessage = nil
        showingForm = true
    }

    private func saveFilm() {
        let saved: Bool
        if let film = editingFilm {
            saved = viewModel.updateFilm(film, title: title, genre: genre, year: year, rating: rating)
        } else {
            saved = viewModel.addFilm(title: title, genre: genre, year: year, rating: rating)
        }
        if saved { showingForm = false }
    }
}
