//
//  ScorePointsView.swift
//  Match-Play
//
//  Created by Tijmen on 10/06/2021.
//

import SwiftUI

struct ScorePointsView: View {
    @State var circleAmount: Int
    var body: some View {
        ForEach(0 ..< circleAmount) {_ in
            Circle()
                .strokeBorder(Color.black,lineWidth: 0.1)
                .background(Circle().foregroundColor(Color(.systemGray5)))
                .frame(width: 20, height: 20)
                
          }
        
    }
}

struct ScorePointsView_Previews: PreviewProvider {
    static var previews: some View {
        ScorePointsView(circleAmount: 10)
    }
}
