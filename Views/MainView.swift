import SwiftUI

struct MainView: View {
    @Environment(\.logger) var logger
    @Environment(\.networkService) var networkService
    @State private var selectedTab = 0
    
    let news: NewsModel?
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    selectedTab = 0
                } label: {
                    HStack {
                        Image(systemName: "newspaper")
                        Text("Home")
                    }
                }
                .buttonStyle(.tabButton)
                .background(selectedTab == 0 ? .white : .gray)
                .foregroundStyle(selectedTab == 0 ? .blue : .black)

                Button {
                    selectedTab = 1
                } label: {
                    HStack {
                        Image(systemName: "chart.bar.horizontal.page")
                        Text("Categories")
                    }
                }
                .buttonStyle(.tabButton)
                .background(selectedTab == 1 ? .white : .gray)
                .foregroundColor(selectedTab == 1 ? .blue : .black)
            }
            
            NavigationView {
                switch selectedTab {
                case 0:
                    HomeView(news: news)
                        .navigationTitle("HOME")
                case 1:
                    CategoriesView()
                        .navigationTitle("CATEGORIES")
                default:
                    EmptyView()
                }
            }
        }
    }
}
