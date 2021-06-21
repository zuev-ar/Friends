//
//  UserDetailView.swift
//  Friends
//
//  Created by Arkasha Zuev on 16.06.2021.
//

import SwiftUI

struct UserDetailView: View {
    let users: [User]
    let user: User
    
    var body: some View {
        VStack {
            CircleView(isActive: user.isActive, width: 100, height: 100)
            
            Text(user.name)
                .font(.title)
            
            Text(user.email)
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding(1)
            
            Divider()
            
            Text(user.company)
                .font(.subheadline)
            
            Text(user.address)
                .font(.subheadline)
                .padding(2)
            
            ScrollView {
                Text(user.about)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(height: 200)
            
            NavigationLink("Friends", destination: FriendsView(users: users, name: user.name, friends: user.friends))
            
            Spacer()
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static let users = [User]()
    static var previews: some View {
        UserDetailView(users: users, user: users[0])
    }
}
