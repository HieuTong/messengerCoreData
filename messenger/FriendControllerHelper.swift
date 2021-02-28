//
//  FriendControllerHelper.swift
//  messenger
//
//  Created by HieuTong on 2/25/21.
//

import UIKit
import Foundation

//class Friend: NSObject {
//    var name: String?
//    var profileImageName: String?
//}
//
//class Message: NSObject {
//    var text: String?
//    var date: NSDate?
//
//    var friend: Friend?
//}
import CoreData

extension FriendController {
    
    
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                let entityNames = ["Friend", "Message"]
                
                for entityName in entityNames {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    
                    guard let objects = try(context.fetch(fetchRequest)) as? [NSManagedObject] else { return }
                    
                    for object in objects {
                        context.delete(object)
                    }
                }
                try (context.save())
            } catch let err {
                print(err)
            }
        }
    }
    
    func setupData() {
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            
            

            createSteveMessagesWithContext(context: context)
            

            let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Trump"
            donald.profileImageName = "donald_trump_profile"

            FriendController.createMessageWithText(text: "You're fired", friend: donald, minutesAgo: 5, context: context)
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            gandhi.name = "Mahatma Gandhi"
            gandhi.profileImageName = "gandhi_profile"
            
            FriendController.createMessageWithText(text: "Love, peace and Joy", friend: gandhi, minutesAgo: 60 * 24, context: context)
            
            let hillary = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            hillary.name = "Hillary Clinton"
            hillary.profileImageName = "hillary_profile"
            
            FriendController.createMessageWithText(text: "Please vote for me, you did for Billy", friend: hillary, minutesAgo: 8 * 60 * 24, context: context)
            
            do {
                try(context.save())
            } catch let err {
                print(err)
            }
        }
        
//        loadData()
    }
    
    private func createSteveMessagesWithContext(context: NSManagedObjectContext) {
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "steveprofile"

        FriendController.createMessageWithText(text: "Good morning", friend: steve, minutesAgo: 3, context: context)
        FriendController.createMessageWithText(text: "Hello, How are you? Hope you are having the good morning", friend: steve, minutesAgo: 2, context: context)
        FriendController.createMessageWithText(text: "Are u interested in buying Apple device? We have a wide variety of Apple devices that will suit your needs. Please make your purchase with us.", friend: steve, minutesAgo: 1, context: context)
        
        //response message
        FriendController.createMessageWithText(text: "Yes, totally looking to buy an iPhone 7.", friend: steve, minutesAgo: 1, context: context, isSender: true)
        FriendController.createMessageWithText(text: "Totally understand what you want the new iPhone 7, but you'll have to wait until September for the new release. Sorry but thats just how Apple likes to do things", friend: steve, minutesAgo: 1, context: context)
        
        FriendController.createMessageWithText(text: "Absolutely, I'll just use my gigantic iPhone 6 Plus until then!!!", friend: steve, minutesAgo: 1, context: context,isSender: true)
        
    }
    
    static func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext, isSender: Bool = false) -> Message {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAgo * 60)
        message.isSender = isSender
        
        friend.lastMessage = message
        
        return message
    }
    
//    func loadData() {
//        let delegate = UIApplication.shared.delegate as? AppDelegate
//        if let context = delegate?.persistentContainer.viewContext {
//            guard let friends = fetchFriends() else { return }
//
//            for friend in friends {
//
//                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
//                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//                fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
//                fetchRequest.fetchLimit = 1
//
//                do {
//                    let fetchedMessages = try(context.fetch(fetchRequest)) as? [Message]
//                    messages.append(contentsOf: fetchedMessages!)
//                } catch let err {
//                    print(err)
//                }
//            }
//
//            messages = messages.sorted(by: {$0.date!.compare($1.date!) == .orderedDescending})
//
//        }
//    }
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")

            do {
                return try context.fetch(fetchRequest) as? [Friend]
            } catch let err {
                print(err)
            }
        }
        return nil
    }
}

