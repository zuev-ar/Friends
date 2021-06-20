//
//  ContentView.swift
//  Friends
//
//  Created by Arkasha Zuev on 20.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest<CDUser>(entity: CDUser.entity(), sortDescriptors: []) private var cdUsers: FetchedResults<CDUser>
    @State private var users = [User]()
    @State private var loadDataOffline = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(users, id: \.self) { user in
                        HStack {
                            NavigationLink(destination: UserDetailView(users: users, user: user)) {
                                CircleView(isActive: user.isActive, width: 50, height: 50)
                                
                                VStack(alignment: .leading, spacing: 7) {
                                    Text(user.name)
                                    Text(user.formattedDate)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .onAppear(perform: loadData)
                .navigationBarTitle("Users")
                
                Text("Amount of CDUsers: \(cdUsers.count)")
                Text("Amount of users: \(users.count)")
                
//                Button("Save") { saveData() }
//                .buttonStyle(GreenButtonStyle())
//
//                Button("Delete") { deleteData() }
//                .buttonStyle(GreenButtonStyle())
            }
        }
    }
    
    func deleteData() {
        for cdUser in cdUsers {
            for cdFriend in cdUser.friendArray {
                viewContext.delete(cdFriend)
            }
        }
        
        for cdUser in cdUsers {
            viewContext.delete(cdUser)
        }
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError("Save error: \(error)")
            }
        }
    }
    
    func saveData() {
        for user in users {
            for friend in user.friends {
                let cdFriend = CDFriend(context: viewContext)
                cdFriend.id = friend.id
                cdFriend.name = friend.name
                cdFriend.origin = CDUser(context: viewContext)
                cdFriend.origin?.id = user.id
                cdFriend.origin?.name = user.name
                cdFriend.origin?.isActive = user.isActive
                cdFriend.origin?.age = Int16(user.age)
                cdFriend.origin?.address = user.address
                cdFriend.origin?.company = user.company
                cdFriend.origin?.about = user.about
                cdFriend.origin?.email = user.email
                cdFriend.origin?.registered = user.registered
            }
        }
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError("Save error: \(error)")
            }
        }
    }
    
    func loadData() {
        if !users.isEmpty {
            return
        }
        
        loadDataFromJSON()
        
        if loadDataOffline {
            loadDataFromCoreData()
        }
    }
    
    func loadDataFromCoreData() {
        
    }
    
    func loadDataFromJSON() {
        guard let url = URL(string: "https://hackingwithswift.com/samples/friendface.json") else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let decoded = try decoder.decode([User].self, from: data)
                        users = decoded
                        saveData()
                        return
                    } catch {
                        print("Decode error:", error)
                    }
                }
            }
            loadDataOffline = true
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct GreenBackground<S: Shape>: View {
    var isHighlight: Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isHighlight {
                shape
                    .fill(Color.green)
                    .shadow(color: Color.green, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.green, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(Color.green)
                    .shadow(color: Color.green, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.green, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct GreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .frame(width: 100, height: 50)
            .contentShape(Rectangle())
            .background(GreenBackground(isHighlight: configuration.isPressed, shape: Rectangle()))
            .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
