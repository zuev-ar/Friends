//
//  SearchBarView.swift
//  Friends
//
//  Created by Arkasha Zuev on 18.06.2021.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search", text: $text)
                .foregroundColor(.primary)
            
            Button {
                self.text = ""
            } label: {
                Image(systemName: "xmark.circle.fill").opacity((text.isEmpty ? 0 : 1))
            }
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        SearchBarView(text: $text)
    }
}
