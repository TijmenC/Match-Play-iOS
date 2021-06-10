//
//  MatchView.swift
//  Match-Play
//
//  Created by Tijmen on 10/06/2021.
//

import SwiftUI

struct MatchView: View {
    @State var firstName = ""
    @State var lastName = ""
    
    var body: some View {
        VStack {
        HStack {
        Text("T. Pieters")
            .padding()
            .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
            .foregroundColor(Color.gray)
        Text("A. Achternaam")
            .padding()
            .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
            .foregroundColor(Color.gray)
        }
        .border(Color.gray)
        HStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 100)
        }
        }
        
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
    }
}
