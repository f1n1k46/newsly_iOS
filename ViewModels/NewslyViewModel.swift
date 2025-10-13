import Foundation

@MainActor
final class NewslyViewModel: ObservableObject {
    @Published var newsModel: NewsModel?
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = NetworkService.shared) {
        self.network = network
    }
    
    func loadTopHeadlines() async {
        do {
            newsModel = try await network.fetchTopHeadlines()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func loadCategoryNews(category: String) async {
        do {
            newsModel = try await network.fetchCategory(category: category)
        } catch {
            print("Error: \(error)")
        }
    }
}
