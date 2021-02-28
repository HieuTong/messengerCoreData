//
//  Message+CoreDataProperties.swift
//  messenger
//
//  Created by HieuTong on 2/26/21.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    @NSManaged public var isSender: Bool
    @NSManaged public var friend: Friend?

}

extension Message : Identifiable {

}
