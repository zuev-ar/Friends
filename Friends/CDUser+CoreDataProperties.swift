//
//  CDUser+CoreDataProperties.swift
//  Friends
//
//  Created by Arkasha Zuev on 20.06.2021.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var friend: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown"
    }

    public var friendArray: [CDFriend] {
        let set = friend as? Set<CDFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
}

// MARK: Generated accessors for friend
extension CDUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CDFriend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CDFriend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension CDUser : Identifiable {

}
