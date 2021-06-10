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
            Divider()
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
            Divider()
            HStack {
                ScorePointsView(circleAmount: 5)
            }
            Image("fall-leave")
                .resizable()
                .scaledToFit()
                .frame(width: 400.0, height: 250.0)
            Divider()
            HStack {
                Text("Place of club")
                    .padding()
                    .frame(width: 200, height: 50, alignment: .leading)
                    .foregroundColor(Color.gray)
                Text("02.03.2042")
                    .padding()
                    .frame(width: 200, height: 50, alignment: .trailing)
                    .foregroundColor(Color.gray)
            }
                Text("I Beat him so hard it's not funny anymore")
                    .frame(width: 400, height: 50)
            Divider()
            HStack {
                HStack {
                Image(systemName: "heart")
                    .font(Font.system(size: 30))
                    .padding(.leading, 5)
                Text("5")
                }.frame(width: 70, height: 50, alignment: .leading)
                HStack {
                Image(systemName: "bubble.left")
                    .font(Font.system(size: 30))
                Text("5")
                }.frame(width: 70, height: 50, alignment: .leading)
                HStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(Font.system(size: 30))
                    Text("Verified")
                } .frame(width: 250, height: 50, alignment: .leading)
            }
            
            
            }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
    }
}
