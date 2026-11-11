import SwiftUI

struct FilmDetailsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "star.fill")
                .font(.system(size: 56))
                .foregroundStyle(.yellow)

            Text("Film details")
                .font(.largeTitle.bold())

            Text("Here you can show information about a selected film: title, genre, year, and rating.")
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
