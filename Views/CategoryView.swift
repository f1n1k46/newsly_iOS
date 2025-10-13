import SwiftUI

struct CategoryView: View {
    @Environment(\.logger) var logger
    @Environment(\.networkService) var networkService

    @StateObject private var nvm = NewslyViewModel()
    @State var news: NewsModel?
    let category: String
    
    var body: some View {
        NavigationView {
            VStack {
                ArticleListView(news: nvm.newsModel)
            }
        }
        .navigationTitle(category.uppercased())
        .padding()
        .task {
            await nvm.loadCategoryNews(category: category)
        }
        .refreshable {
            await nvm.loadCategoryNews(category: category)
        }
    }
}
