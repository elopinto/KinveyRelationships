//
//  Event.swift
//  KinveyRelationships
//
//  Created by Edward LoPinto on 3/2/16.
//  Copyright © 2016 Edward LoPinto. All rights reserved.
//

import Foundation


class Event: NSObject {
 
    var entityId: String? //Kinvey entity _id
    var name: String?
    var date: NSDate?
    var location: String?
    var metadata: KCSMetadata? //Kinvey metadata, optional
    var invitations: NSMutableSet?
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "name" : "name",
            "date" : "date",
            "location" : "location",
            "invitations" : "invitations",
            "metadata" : KCSEntityKeyMetadata
        ]
    }
    
    override static func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
            "invitations" /* backend field name */ : "Invitations", /* collection name for invitations */
        ]
    }
    
    override static func kinveyObjectBuilderOptions() -> [NSObject : AnyObject]! {
        return [
            KCS_REFERENCE_MAP_KEY : [
                "invitations" : Invitation.self
            ]
        ]
    }

    override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        return ["invitations"]
    }
}