//
//  ViewController.swift
//  KinveyRelationships
//
//  Created by Edward LoPinto on 3/2/16.
//  Copyright © 2016 Edward LoPinto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mc: MC!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Save an MC entity, or create one if none exists. This is done now to avoid the
        // deeply nested saves, i.e. `invitationWithNoId.event = someEventWithNoId`,
        // where `someEventWithNoId.mc = someMcWithNoObjectId`.
        let mc = MC()
        mc.name = "Jay-Z"
        
        let store = KCSAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName: "MCs",
            KCSStoreKeyCollectionTemplateClass: MC.self
        ])
        
        store.saveObject(mc, withCompletionBlock: { (results, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("MC saved")
                self.mc = results[0] as! MC
            }
        }, withProgressBlock: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
    This action attempts to save a one-to-many relationship between an event and several
    invitations. It causes the app to crash with:
        'NSInvalidArgumentException', reason: 'Invalid type in JSON write (KCSKinveyRef)'
    */
    @IBAction func saveEvent(sender: UIButton) {
        let event = Event()
        event.name = "Kanye's Birthday"
        event.date = NSDate.distantPast()
        event.location = "Hollywood"
        
        let inviteA = Invitation()
        inviteA.status = 0
        inviteA.invitee = KCSUser.activeUser()
        
        let inviteB = Invitation()
        inviteB.status = 1
        inviteB.invitee = KCSUser.activeUser()
        
        event.invitations = NSMutableSet(array: [inviteA, inviteB])
        
        let linkedStore = KCSLinkedAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName: "Events",
            KCSStoreKeyCollectionTemplateClass: Event.self
        ])
        
        linkedStore.saveObject(event, withCompletionBlock: { (results, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("yay!")
            }
        }, withProgressBlock: nil)
    }

    /**
    This action creates an `Event` and two `Invitations` and for each `Invitation` sets a "to-one"
    relationship with the `Event`. This successfully saves the all three entities.
    */
    @IBAction func saveInvitations(sender: UIButton) {
        let event = Event()
        event.name = "Kanye's Birthday"
        event.date = NSDate.distantPast()
        event.location = "Hollywood"
        
        let inviteA = Invitation()
        inviteA.status = 0
        inviteA.invitee = KCSUser.activeUser()
        inviteA.event = event
        
        let inviteB = Invitation()
        inviteB.status = 1
        inviteB.invitee = KCSUser.activeUser()
        inviteB.event = event
        
        let linkedStore = KCSLinkedAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName: "Invitations",
            KCSStoreKeyCollectionTemplateClass: Invitation.self
            ])
        
        linkedStore.saveObject([inviteA, inviteB], withCompletionBlock: { (results, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("yay!")
            }
        }, withProgressBlock: nil)
    }
    
    /**
     This action creates an `EventWithKinveyRef` and two `Invitations` and for each `Invitation`
     sets a "to-one" relationship with the `EventWithKinveyRef`. Unlike the `EventWithKinveyRef`
     has a "to-one" relationship pointing to an entity from another collection. The save operation
     fails with:
         'NSInvalidArgumentException', reason: 'Invalid type in JSON write (KCSKinveyRef)'
     */
    @IBAction func saveInvitationsAlternative(sender: UIButton) {
        let event = EventWithKinveyRef()
        event.name = "Kanye's Birthday"
        event.date = NSDate.distantPast()
        event.location = "Hollywood"
        event.mc = mc
        
        let inviteA = AltInvite()
        inviteA.status = 0
        inviteA.invitee = KCSUser.activeUser()
        inviteA.event = event
        
        let inviteB = AltInvite()
        inviteB.status = 1
        inviteB.invitee = KCSUser.activeUser()
        inviteB.event = event
        
        let linkedStore = KCSLinkedAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName: "Invitations",
            KCSStoreKeyCollectionTemplateClass: AltInvite.self
            ])
        
        linkedStore.saveObject([inviteA, inviteB], withCompletionBlock: { (results, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("yay!")
            }
        }, withProgressBlock: nil)
    }
}

