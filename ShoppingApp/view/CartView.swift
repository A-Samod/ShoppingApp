import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @State var totalPrice = 0.00
    @State var subTotal = 0.0
    @State var shipping = 0.0
    @State var totalWithShipping = 0.0
    
    @State private var showAlert = false
    @State private var navigateTohome = false
    
    var body: some View {
        VStack {
            Text("Your Cart")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                ForEach(cartItems, id: \.cartId) { item in
                    HStack {
                        AnimatedImage(url: URL(string: item.imageURL))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 60)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.name)
                                .font(.headline)
                            Text("Price: \(String(format: "%.2f", item.price))")
                            Text("Quantity: \(item.quantity)")
                            Text("Size: \(item.size)")
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(uiColor: .systemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .padding(.horizontal)
                }
                .onDelete(perform: deleteItem)
            }
            
            Divider().padding(.horizontal)
            
            summaryView.padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                showAlert = true
                self.navigateTohome = true
            }) {
                Text("Checkout")
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Success"), message: Text("Item added chckoutsuccessfully"), dismissButton: .default(Text("OK")))
                    }
            }
            .padding(.bottom, 50)
        }
        .onAppear(perform: calculateTotalPrice)
        
    }
    
    
    var summaryView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Subtotal:")
                Spacer()
                Text("LKR \(String(format: "%.2f", subTotal))")
            }
            
            HStack {
                Text("Shipping:")
                Spacer()
                Text("LKR \(String(format: "%.2f", shipping))")
            }
            
            Divider()
            
            HStack {
                Text("Total:")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Text("LKR \(String(format: "%.2f", totalWithShipping))")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }
        }
    }
    
    func calculateTotalPrice() {
        subTotal = cartItems.reduce(0.0) { $0 + $1.price * Double($1.quantity) }
        shipping = subTotal > 0 ? 300.0 : 0.0
        totalWithShipping = subTotal + shipping
    }
    
    func deleteItem(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)
        calculateTotalPrice()
    }
    
}

#Preview {
    CartView()
}

