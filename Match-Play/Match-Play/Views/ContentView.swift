//
//  ContentView.swift
//  Match-Play
//
//  Created by Tijmen on 10/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var email = "ioscase"
    @State var password = "iOSCase"
    @State var isActive = false
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Match Play").font(.title.bold()).padding()
            
                Text("Username").padding(.trailing).font(.title2.bold())
            TextField("Enter username", text: $email)
                .padding()
                Divider()
                Text("Password").padding(.trailing).font(.title2.bold())
            TextField("Enter password", text: $password)
                .padding()
                Divider()
            NavigationLink(destination: UserFeed(results: AllData(data: [])), isActive: $isActive) {
            Button(action: {
                postLogin()
                
            }) {
                
                Text("Login")
                
            }
            } .padding()
            if self.showingConfirmation {
                Text(confirmationMessage)
                    .foregroundColor(.red)
            }
         
        }.padding()
            
        }

    }
    
    
    func postLogin() {
        let user: LoginUser = .init(email: email, password: password)
        let userData = try! JSONEncoder().encode(user)
        let url = URL(string: "https://api.wearematchplay.com/v2/auth/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = userData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                self.isActive = false
                return
            }
            if let decodedUser = try? JSONDecoder().decode(Token.self, from: data) {
                print(decodedUser.api_token)
                UserDefaults.standard.set(decodedUser.api_token, forKey: "savedToken")
                if (decodedUser.api_token == nil){
                    self.isActive = false
                    confirmationMessage = "You used an incorrect email/password!"
                    showingConfirmation = true
                }
                else{
                    self.isActive = true
                    showingConfirmation = false
                }
              
               
                
              
                
            } else {
                print("Invalid response from server")
                confirmationMessage = "There was a trouble with the server!"
             showingConfirmation = true
                self.isActive = false
            }
        }.resume()
    }
   
   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
