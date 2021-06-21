//
//  FriendsView.swift
//  Friends
//
//  Created by Arkasha Zuev on 17.06.2021.
//

import SwiftUI

struct FriendsView: View {
    let users: [User]
    let name: String
    let friends: [User.Friend]
    
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBarView(text: $searchText)
            
            List {
                ForEach(friends.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) }), id: \.self) { friend in 
                    NavigationLink(destination: UserDetailView(users: users, user: users.first(where: { $0.id == friend.id })!)) {
                        Text(friend.name)
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarTitle(Text(name), displayMode: .inline)
    }
}

struct FriendsView_Previews: PreviewProvider {
    static let users = [User]()
    static var previews: some View {
        FriendsView(users: users, name: "", friends: users[0].friends)
    }
}
