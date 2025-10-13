import SwiftUI

struct ArticleView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(12)
            }
            
            Text(article.title)
                .font(.headline)
            
            if let description = article.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let url = URL(string: article.url) {
                Link("Read full article...", destination: url)
                    .frame(alignment: .center)
            }
        }
        .padding()
    }
}
