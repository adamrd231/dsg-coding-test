//
//  HomeViewModel.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    @Published var favorites: [String] = []
    
    let userDefaults = UserDefaults.standard
    
    
    @Published var selectedEvent: Event?
    // Current Search Text
    @Published var searchText: String = ""
    
    var seatGeekDataService: SeatGeekDataService = SeatGeekDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        getFavorites()
    }
    
    func getFavorites() {
        if let userDefaultsSaved = userDefaults.array(forKey: "favorites") as? [String] {
            favorites = userDefaultsSaved
        }
        
    }
    
    
    func contains(_ eventName: String) -> Bool {
        return favorites.contains(eventName)
    }
    
    func removeEvent(_ eventName: String) {
        favorites.removeAll(where: { $0 == eventName })
        userDefaults.set(favorites, forKey: "favorites")
    }
    
    func addEvent(_ eventName: String) {
        if !favorites.contains(eventName) {
            favorites.append(eventName)
        }
        userDefaults.set(favorites, forKey: "favorites")
        
    }
    
    
    func addSubscribers() {
        $searchText
            .sink { recievedString in
                print("Search: \(recievedString)")
                self.seatGeekDataService.getEvents(text: recievedString)
            }
            .store(in: &cancellables)
        
        seatGeekDataService.$events
            
//            .combineLatest($searchText)
//            .map(filterSearchText)
            .sink { (returnedEvents) in
                self.events = returnedEvents
                }
            .store(in: &cancellables)
        
        
    }
    
    func filterSearchText(events: [Event], searchText: String) -> [Event] {
        guard !searchText.isEmpty else { return events }
        
        let lowercasedText = searchText.lowercased()
        
        return events.filter { (event) -> Bool in
            return event.title?.lowercased().contains(lowercasedText) ?? true
        }
    }
    
    

}
