import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @State var totalPrice = 0.00
    @State var subTotal = 0.0
    @State var deliveryFee = 0.0
    @State var totalWithDelivery = 0.0
    @State var selectedPaymentOption = PaymentOption.cashOnDelivery
    @State private var showAlert = false
    @State private var navigateToHome = false
    @State private var navigateToLogin = false
    
    var body: some View {
        VStack {
            Text("My Cart")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.black)
            
            ScrollView {
                ForEach(cartItems, id: \.cartId) { item in
                    CartItemRow(item: item, onDelete: {
                        deleteCartItem(item)
                    })
                }
                .onDelete(perform: deleteItem)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Subtotal")
                        .foregroundColor(.black)
                    Spacer()
                    Text("LKR \(String(format: "%.2f", subTotal))")
                        .foregroundColor(.black)
                }
                
                Divider()
                
                PaymentOptionPicker(selectedOption: $selectedPaymentOption, recalculateTotal: calculateTotalPrice)
                
                Divider()
                
                HStack {
                    Text("Payment Option")
                        .foregroundColor(.black)
                    Spacer()
                    Text(selectedPaymentOption.rawValue)
                        .foregroundColor(.black)
                }
                
                Divider()
                
                HStack {
                    Text("Delivery Fee")
                        .foregroundColor(.black)
                    Spacer()
                    Text("LKR \(String(format: "%.2f", deliveryFee))")
                        .foregroundColor(.black)
                }
                
                HStack {
                    Text("Total:")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                    Text("LKR \(String(format: "%.2f", totalWithDelivery))")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
            .padding(.vertical, 4)
            
            Spacer()
            
            Button(action: {
                showAlert = true
            }) {
                Text("Checkout")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(50)
                    .padding()
            }
            .padding(.bottom, 50)
            .alert(isPresented: $showAlert) {
                let message = "Items added to cart successfully. Thank you for your purchase!"
                return Alert(title: Text("Success"), message: Text(message), dismissButton: .default(Text("OK"), action: {
                    clearCartItems()
                    navigateToHome = true
                }))
            }
            .fullScreenCover(isPresented: $navigateToHome) {
                HomeView()
            }
        }
        .padding(.horizontal)
        .onAppear(perform: calculateTotalPrice)
    }
    
    func calculateTotalPrice() {
        subTotal = cartItems.reduce(0.0) { $0 + $1.price * Double($1.quantity) }
        switch selectedPaymentOption {
        case .cashOnDelivery:
            deliveryFee = 600.0
        case .cardPayment:
            deliveryFee = 500.0
        }
        totalWithDelivery = subTotal + deliveryFee
    }
    
    func deleteItem(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)
        calculateTotalPrice()
    }
    
    func clearCartItems() {
        cartItems.removeAll()
    }
    
    func deleteCartItem(_ item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.cartId == item.cartId }) {
            cartItems.remove(at: index)
            calculateTotalPrice()
        }
    }
}

struct PaymentOptionPicker: View {
    @Binding var selectedOption: PaymentOption
    var recalculateTotal: () -> Void
    
    var body: some View {
        HStack {
            Text("Payment Option")
                .foregroundColor(.black)
            Spacer()
            Picker("Payment Option", selection: $selectedOption) {
                ForEach(PaymentOption.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .onChange(of: selectedOption) { _ in
            recalculateTotal()
        }
    }
}



struct CartItemRow: View {
    let item: CartItem
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            AnimatedImage(url: URL(string: item.imageURL))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Text("Price: \(String(format: "%.2f", item.price))")
                    .foregroundColor(.gray)
                Text("Quantity: \(item.quantity)")
                    .foregroundColor(.gray)
                Text("Size: \(item.size)")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                onDelete()
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .padding(.trailing, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .padding(.vertical, 8)
    }
}

enum PaymentOption: String, CaseIterable {
    case cashOnDelivery = "COD"
    case cardPayment = "Card"
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
