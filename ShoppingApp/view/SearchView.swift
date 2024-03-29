import SwiftUI

struct SearchView: View {
    @StateObject var productsViewModel = ProductsViewModel()
    
    @State private var gridColumns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    @State private var searchText = ""
    
    @State private var isAscendingSort = true
    
    init(searchTerm: String) {
        self._searchText = State(initialValue: searchTerm)
    }
    
    var filteredProducts: [Product] {
        var filtered = searchText.isEmpty ? productsViewModel.products : productsViewModel.products.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
        
        if isAscendingSort {
            filtered.sort { $0.price < $1.price }
        } else {
            filtered.sort { $0.price > $1.price }
        }
        
        return filtered
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Sort By", selection: $isAscendingSort) {
                    Text("Low to High").tag(true)
                    Text("High to Low").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 25) {
                        ForEach(filteredProducts, id: \.id) { product in
                            ProductTileView(product: product)
                                .padding([.horizontal,.top])
                        }
                    }
                    .background(Color.white.edgesIgnoringSafeArea(.all))
                }
                .navigationTitle("Find the best clothes")
                .searchable(text: $searchText, prompt: "Search Items")
            }
        }
    }
}
