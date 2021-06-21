//
//  CircleView.swift
//  Friends
//
//  Created by Arkasha Zuev on 17.06.2021.
//

import SwiftUI

struct CircleView: View {
    var isActive: Bool
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Circle()
            .fill(isActive ? Color.gray : Color.green)
            .frame(width: width, height: width)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(isActive: true, width: 100, height: 100)
    }
}
