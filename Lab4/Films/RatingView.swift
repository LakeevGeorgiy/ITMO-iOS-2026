import SwiftUI
import SwiftData

struct RatingView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = RatingViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Image(systemName: "film.stack")
                    .font(.system(size: 62))
                    .foregroundStyle(.orange)

                Text("Film Ratings")
                    .font(.largeTitle.bold())

                if let rating = viewModel.rating {
                    Text("Random rating: \(rating) / 10")
                        .font(.title2.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
                }

                Button(action: viewModel.generateRating) {
                    Label("Get random rating", systemImage: "dice")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)

                NavigationLink {
                    FilmDetailsView(context: modelContext)
                } label: {
                    Label("My films", systemImage: "chevron.right")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)

                Spacer()
            }
            .padding()
            .navigationTitle("Films")
            .toolbar {
                if viewModel.rating != nil {
                    Button("Clear rating", action: viewModel.clearRating)
                }
            }
        }
    }
}

#Preview {
    RatingView()
        .modelContainer(for: Film.self, inMemory: true)
}
