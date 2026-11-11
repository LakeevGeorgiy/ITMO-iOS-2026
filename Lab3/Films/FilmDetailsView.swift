import SwiftUI

struct FilmDetailsView: View {
    @StateObject private var viewModel = FilmDetailsViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "star.fill")
                .font(.system(size: 56))
                .foregroundStyle(.yellow)

            Text(viewModel.film.title)
                .font(.largeTitle.bold())

            Text(viewModel.detailsText)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)

            Spacer()
        }
        .padding(.top, 48)
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FilmDetailsView()
    }
}
