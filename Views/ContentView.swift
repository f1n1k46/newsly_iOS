import SwiftUI

struct ContentView: View {
    @Environment(\.logger) var logger
    @Environment(\.networkService) var networkService
    
    @StateObject private var nvm = NewslyViewModel()
    @State var news: NewsModel?
    
    var body: some View {
        VStack {
            MainView(news: nvm.newsModel)
        }
        .padding()
        .task {
            await nvm.loadTopHeadlines()
        }
        .refreshable {
            await nvm.loadTopHeadlines()
        }
    }
}
