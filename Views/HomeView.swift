import SwiftUI

struct HomeView: View {
    let news: NewsModel?
    
    var body: some View {
        ArticleListView(news: news)
    }
}
