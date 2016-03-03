//
//  AltInvite.swift
//  KinveyRelationships
//
//  Created by Edward LoPinto on 3/3/16.
//  Copyright © 2016 Edward LoPinto. All rights reserved.
//

import Foundation

// Indentical to `Invitation`, but using the EventWithKinveyRef class as the property type.
class AltInvite: NSObject {
    
    var objectId: String?
    var status: NSNumber? //Error in example: NSInteger should be NSNumber
    var invitee: KCSUser?
    var event: EventWithKinveyRef?
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "objectId" : KCSEntityKeyId,
            "status" : "status",
            "invitee" : "invitee",
            "event" : "event"
        ]
    }
    
    static override func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
            "invitee" : KCSUserCollectionName,
            "event" : "Events"
        ]
    }
    
    override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        return ["event"]
    }
}