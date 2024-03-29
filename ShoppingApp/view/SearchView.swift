import SwiftUI

struct SearchView: View {
    @StateObject var productsViewModel = ProductsViewModel()
    
    @State private var gridColumns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    @State private var searchText = ""
    
    @State private var isAscendingSort = true
    @State private var selectedPriceFilter = "All"
    
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
        
        if selectedPriceFilter != "All" {
            let priceRange = getPriceRange(for: selectedPriceFilter)
            filtered = filtered.filter { product in
                if let price = Double(product.price) {
                    return priceRange.contains(price)
                } else {
                    return false
                }
            }
        }
        
        return filtered
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Divider().padding(.horizontal)
                HStack {
                    Text("Sort By")
                        .font(.headline)
                        .padding(.leading)
                    
                 //   Spacer()
                    
                    Toggle(isOn: $isAscendingSort) {
                        Text("Low to High")
                    }
                    .padding(.trailing)
                }
                .padding(.vertical)
                Divider().padding(.horizontal)
                HStack {
                    Text("Filter By Price")
                        .font(.headline)
                        .padding(.leading)
                    
                    Spacer()
                    
                    Menu(selectedPriceFilter) {
                        ForEach(["All", "Under LKR 500", "LKR 500 - LKR 1500", "LKR 1500 - LKR 2500", "Over LKR 2500"], id: \.self) { filter in
                            Button(filter) {
                                selectedPriceFilter = filter
                            }
                        }
                    }
                    .padding(.trailing)
                }
                .padding(.vertical)
                Divider().padding(.horizontal)
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 25) {
                        ForEach(filteredProducts, id: \.id) { product in
                            ProductTileView(product: product)
                                .padding([.horizontal,.top])
                        }
                    }
                    .background(Color.white.edgesIgnoringSafeArea(.all))
                }
//                .navigationTitle("Discover Your Style")
//                Spacer()
                .searchable(text: $searchText, prompt: "Discover Your Style")
            }
        }
    }
    
    func getPriceRange(for filter: String) -> ClosedRange<Double> {
        switch filter {
        case "Under LKR 500":
            return 0.0...499.99
        case "LKR 500 - LKR 1500":
            return 500.0...1499.99
        case "LKR 1500 - LKR 2500":
            return 1500.0...2499.00
        case "Over LKR 2500":
            return 2500.0...Double.greatestFiniteMagnitude
        default:
            return 0.0...Double.greatestFiniteMagnitude
        }
    }
}

