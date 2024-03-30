import SwiftUI

struct ProfileView: View {
    @State private var isEditing = false
    @State private var userName = "user"
    @State private var email = "user@gmail.com"
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var navigateToSignIn = false
    @StateObject var loginVM = SignInViewModel.signIn;
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.black)
                .padding(.bottom, 20)
            
            Text(userName)
                .font(.title)
                .fontWeight(.bold)
            
            Text(email)
                .foregroundColor(.gray)
            
            Divider()
                .padding(.vertical, 20)
            
            if isEditing {
                VStack(alignment: .leading, spacing: 15) {
                    TextField("New Password", text: $newPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        newPassword = ""
                        confirmPassword = ""
                        isEditing = false
                        ProfileView()
                    }) {
                        Text("Update Password")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(50)
                    }
                }
                .padding()
            } else {
                Button(action: {
                    isEditing = true
                }) {
                    Text("Change Password")
                        .foregroundColor(.blue)
                        .padding()
                }
                Button(action: {
                    showAlert = true
                    // SignInView()
                    loginVM.isUserLogin = false
                    navigateToSignIn = true
                    
                    
                }) {
                    Text("Log Out")
                        .fontWeight(.semibold)
                        .frame(maxWidth: 320)
                        .frame(height: 60)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .padding(.top, 200)
                }
                .padding(.bottom, 50)

            }
            
            Spacer()
                    }
        .padding()
        .fullScreenCover(isPresented: $navigateToSignIn) {
            SignInView()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

