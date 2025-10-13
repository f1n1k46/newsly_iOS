import SwiftUI

struct CategoryLink: View {
    let title: String
    let imageName: String

    var body: some View {
        NavigationLink(destination: CategoryView(category: title)) {
            ZStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(16)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.indigo)
                    .overlay(
                        Color.secondary.opacity(0.4)
                            .cornerRadius(16)
                    )

                Text(title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .shadow(radius: 3)
            }
        }
        .buttonStyle(.plain)
    }
}
