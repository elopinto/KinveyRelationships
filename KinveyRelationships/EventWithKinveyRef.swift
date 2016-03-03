//
//  EventWithKinveyRef.swift
//  KinveyRelationships
//
//  Created by Edward LoPinto on 3/3/16.
//  Copyright © 2016 Edward LoPinto. All rights reserved.
//

import Foundation

// Identical to `Event` class, but with additional `mc` property that points to an entity from the
// `MCs` collection, and referencing the `AltInvite` class.
class EventWithKinveyRef: NSObject {
    
    var entityId: String? //Kinvey entity _id
    var name: String?
    var date: NSDate?
    var location: String?
    var metadata: KCSMetadata? //Kinvey metadata, optional
    var invitations: NSMutableSet?
    var mc: MC?
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "name" : "name",
            "date" : "date",
            "location" : "location",
            "invitations" : "invitations",
            "mc": "mc",
            "metadata" : KCSEntityKeyMetadata
        ]
    }
    
    override static func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
            "invitations" /* backend field name */ : "Invitations", /* collection name for invitations */
            "mc": "MCs"
        ]
    }
    
    override static func kinveyObjectBuilderOptions() -> [NSObject : AnyObject]! {
        return [
            KCS_REFERENCE_MAP_KEY : [
                "invitations" : AltInvite.self
            ]
        ]
    }
    
    override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        //I also tried removing `mc` from the array to see if the automatic saving was causing the
        //crash when saving an entity the refers to another entity. It did not solve the problem.
        return ["invitations", "mc"]
    }
}