import SwiftUI

struct RatingView: View {
    @State private var rating: Int?

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Image(systemName: "film.stack")
                    .font(.system(size: 62))
                    .foregroundStyle(.orange)

                Text("Film Ratings")
                    .font(.largeTitle.bold())

                if let rating {
                    Text("Random rating: \(rating) / 10")
                        .font(.title2.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
                }

                Button(action: generateRating) {
                    Label("Get random rating", systemImage: "dice")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)

                NavigationLink {
                    FilmDetailsView()
                } label: {
                    Label("Open film details", systemImage: "chevron.right")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)

                Spacer()
            }
            .padding()
            .navigationTitle("Films")
        }
    }

    private func generateRating() {
        rating = Int.random(in: 1...10)
    }
}

#Preview {
    RatingView()
}
