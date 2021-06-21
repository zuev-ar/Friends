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
    @State private var users = [CDUser]()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(users, id: \.self) { user in
                        HStack {
                            NavigationLink(destination: UserDetailView(users: users, user: user)) {
                                CircleView(isActive: user.isActive, width: 50, height: 50)

                                VStack(alignment: .leading, spacing: 7) {
                                    Text(user.wrappedName)
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
                .navigationBarItems(leading: Button(action: {
                    deleteData()
                }, label: {
                    Image(systemName: "xmark.bin.fill")
                        .foregroundColor(.red)
                }), trailing: Button(action: {
                    saveData()
                }, label: {
                    Image(systemName: "square.and.arrow.down.fill")
                }))
            }
        }
    }
    
    func deleteData() {
        for user in users {
            for friend in user.friendArray {
                viewContext.delete(friend)
            }
        }
        for user in users {
            viewContext.delete(user)
        }
        saveChanges()
        users.removeAll()
    }
    
    func saveData() {
        for user in users {
            for friend in user.friendArray {
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
        
        saveChanges()
    }
    
    func loadData() {
        if NetworkService.isConnectedToNetwork()  {
            loadDataFromInternet()
        } else {
            loadDataFromCoreData()
        }
    }
    
    func loadDataFromCoreData() {
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        DispatchQueue.main.async {
            do {
                self.users = try viewContext.fetch(fetchRequest)
            } catch {
                print("Load error: \(error)")
            }
        }
    }
    
    func loadDataFromInternet() {
        guard let url = URL(string: "https://hackingwithswift.com/samples/friendface.json") else {
            return
        }

        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = viewContext
                decoder.dateDecodingStrategy = .iso8601
                DispatchQueue.main.async {
                    do {
                        let decoded = try decoder.decode([CDUser].self, from: data)
                        self.users = decoded
                    } catch {
                        print("Decode error:", error)
                    }
                }
            }
        }.resume()
    }
    
    func saveChanges() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError("Save error: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
