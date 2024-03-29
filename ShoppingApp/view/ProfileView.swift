import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text("John Doe")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("johndoe@example.com")
                .foregroundColor(.gray)
            
            Spacer()
            
            Button(action: {
                
            }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding()
        }
        .navigationBarTitle("Profile")
    }
}

#Preview {
    ProfileView()
}
