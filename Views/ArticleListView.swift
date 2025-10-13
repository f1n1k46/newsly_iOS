import SwiftUI

struct ArticleListView: View {
    let news: NewsModel?
    @State var searchText = ""
    @State private var filteredArticles: [Article] = []
    @State var allArticles: [Article] = []
    
    var body: some View {
        VStack {
            List(filteredArticles) { article in
                NavigationLink(destination: ArticleView(article: article)) {
                    VStack {
                        if let urlToImage = article.urlToImage, let image = URL(string: urlToImage) {
                            AsyncImage(url: image) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 280, height: 200)
                            .clipped()
                            .cornerRadius(12)
                        }
                        Text(article.title)
                            .multilineTextAlignment(.leading)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .listStyle(.plain)
            .searchable(text: $searchText)
            .onSubmit(of: .search, performSearch)
            .onAppear() {
                filteredArticles = news?.articles ?? []
            }
            .onChange(of: news?.articles) { newArticles in
                if let articles = newArticles {
                    filteredArticles = articles
                    allArticles = articles
                }
            }
            .onChange(of: searchText) { newValue in
                if newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    withAnimation(.easeInOut) {
                        filteredArticles = allArticles
                    }
                }
            }
        }
    }
    
    private func performSearch() {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredArticles = allArticles
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                let filtered = allArticles.filter {
                    $0.title.localizedCaseInsensitiveContains(searchText)
                }
                DispatchQueue.main.async {
                    withAnimation(.easeInOut) {
                        filteredArticles = filtered
                    }
                }
            }
        }
    }
}
