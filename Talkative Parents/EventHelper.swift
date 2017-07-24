//
//  EventHelper.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 13/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import EventKit

class EventHelper
{
    let appleEventStore = EKEventStore()
    var calendars: [EKCalendar]?
    
    func generateEvent(pCalendarEvent : CalendarEvent) {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status)
        {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccessToCalendar(pCalendarEvent : pCalendarEvent)
        case EKAuthorizationStatus.authorized:
            // User has access
            print("User has access to calendar")
            self.addAppleEvents(pCalendarEvent : pCalendarEvent)
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            noPermission()
        }
    }
    
    func noPermission()
    {
        print("User has to change settings...goto settings to view access")
    }
    
    func requestAccessToCalendar(pCalendarEvent : CalendarEvent) {
        appleEventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                DispatchQueue.main.async {
                    print("User has access to calendar")
                    self.addAppleEvents(pCalendarEvent : pCalendarEvent)
                }
            } else {
                DispatchQueue.main.async{
                    self.noPermission()
                }
            }
        })
    }
    
    func addAppleEvents(pCalendarEvent : CalendarEvent)
    {
        let event:EKEvent = EKEvent(eventStore: appleEventStore)
        event.title = pCalendarEvent.getTitle()
        event.startDate = pCalendarEvent.getStartDate()
        event.endDate = pCalendarEvent.getEndDate()
        event.notes = pCalendarEvent.getDescription()
        event.calendar = appleEventStore.defaultCalendarForNewEvents
        
        do {
            try appleEventStore.save(event, span: .thisEvent)
            print("events added with dates:")
        } catch let e as NSError {
            print(e.description)
            return
        }
        print("Saved Event")
    }
}
