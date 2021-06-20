//
//  CDFriend+CoreDataProperties.swift
//  Friends
//
//  Created by Arkasha Zuev on 20.06.2021.
//
//

import Foundation
import CoreData


extension CDFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFriend> {
        return NSFetchRequest<CDFriend>(entityName: "CDFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var origin: CDUser?

    public var wrappedName: String {
        name ?? "Unknown"
    }
    
}

extension CDFriend : Identifiable {

}
