import SwiftUI

enum Categories: String {
    case sport = "sport"
    case auto = "auto"
    case crypto = "crypto"
    case science = "science"
}

struct CategoriesView: View {
    @Environment(\.logger) var logger
    @Environment(\.networkService) var networkService
    
    @State var news: NewsModel?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                CategoryLink(title: Categories.sport.rawValue.uppercased(), imageName: "sportscourt")
                CategoryLink(title: Categories.auto.rawValue.uppercased(), imageName: "car.side")
                CategoryLink(title: Categories.crypto.rawValue.uppercased(), imageName: "bitcoinsign")
                CategoryLink(title: Categories.science.rawValue.uppercased(), imageName: "atom")
            }
            .padding()
        }
    }
}
