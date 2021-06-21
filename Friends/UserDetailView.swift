//
//  UserDetailView.swift
//  Friends
//
//  Created by Arkasha Zuev on 16.06.2021.
//

import SwiftUI

struct UserDetailView: View {
    let users: [CDUser]
    let user: CDUser
    
    var body: some View {
        VStack {
            CircleView(isActive: user.isActive, width: 100, height: 100)
            
            Text(user.wrappedName)
                .font(.title)
            
            Text(user.email!)
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding(1)
            
            Divider()
            
            Text(user.company!)
                .font(.subheadline)
            
            Text(user.address!)
                .font(.subheadline)
                .padding(2)
            
            ScrollView {
                Text(user.about!)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(height: 200)
            
            NavigationLink("Friends", destination: FriendsView(users: users, name: user.name!, friends: user.friendArray))
            
            Spacer()
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static let users = [CDUser]()
    static var previews: some View {
        UserDetailView(users: users, user: users[0])
    }
}
