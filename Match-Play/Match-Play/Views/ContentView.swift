//
//  ContentView.swift
//  Match-Play
//
//  Created by Tijmen on 10/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var email = ""
    @State var password = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State var results = [User]()
    var body: some View {
        VStack(alignment: .leading) {
            Text("Username").padding(.trailing)
            TextField("Enter username", text: $email)
                .padding()
            Text("Password").padding(.trailing)
            TextField("Enter password", text: $password)
                .padding()
            Button(action: {
                    postLogin()
                        
                    }) {
                        
                        Text("Login")
                        
                    }
            .padding()
        }.padding()
        }
    
    
    func postLogin() {
        let user: User = .init(email: email, password: password)
        let userData = try! JSONEncoder().encode(user)
        let url = URL(string: "https://api.wearematchplay.com/v2/auth/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = userData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Token.self, from: data) {
                print(decodedOrder)
            } else {
                print("Invalid response from server")
                print(data)
            }
        }.resume()
    }
        func parseJson<T: Decodable>(data: Data, type: T.Type) -> T? {
            do {
                return try JSONDecoder().decode(type.self, from: data)
            } catch {
                print("JSON decode error:", error)
                return nil
            }
        }
    func loadData() {
            guard let url = URL(string: "https://api.wearematchplay.com/v2/") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode([User].self, from: data) {
                        DispatchQueue.main.async {
                            self.results = response
                        }
                        return
                    }
                }
            }.resume()
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
