import SwiftUI

// Custom section header
struct CustomHeaderView: View {
    let title: String

    var body: some View {
        ZStack {
            Color.gray.opacity(0.5) // Background color
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.leading, 10)
        }
        .frame(height: 30)
    }
}

// List view with navigation
struct ListView: View {
    let sections: [SectionData] = [
        SectionData(title: "SwiftUI", items: [
            Item(name: "With Composable Architecture", id: 0),
            Item(name: "Without Composable Architecture", id: 1)
        ], id: 0),
        SectionData(title: "Swift", items: [
            Item(name: "With Composable Architecture", id: 2),
            Item(name: "Without Composable Architecture", id: 3)
        ], id: 1)
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(sections) { section in
                    Section(header: CustomHeaderView(title: section.title)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: destinationView(for: item)) {
                                Text(item.name)
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Different Approaches")
        }
    }
    
    // Extracted function for destination view to improve performance
    @ViewBuilder
    private func destinationView(for item: Item) -> some View {
        if item.id.isMultiple(of: 2) {
            ContentView()
                .onAppear { clearUserDefaults() }
        } else {
            BottomTabView()
//                .onAppear { clearUserDefaults() }
//            LoginView()
        }
    }
    
    // Function to remove UserDefaults
    private func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "authToken")
        UserDefaults.standard.synchronize()
    }
}

