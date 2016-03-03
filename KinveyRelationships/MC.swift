//
//  MC.swift
//  KinveyRelationships
//
//  Created by Edward LoPinto on 3/3/16.
//  Copyright © 2016 Edward LoPinto. All rights reserved.
//

import Foundation

class MC: NSObject {
    
    var entityId: String? //Kinvey entity _id
    var name: String?
    var metadata: KCSMetadata? //Kinvey metadata, optiona
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "name" : "name",
            "metadata" : KCSEntityKeyMetadata
        ]
    }

}