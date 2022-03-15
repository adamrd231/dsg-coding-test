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
    @Published var selectedEvent: Event?
    // Current Search Text
    @Published var searchText: String = ""
    
    private var seatGeekDataService: SeatGeekDataService = SeatGeekDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        seatGeekDataService.$events
            .combineLatest($searchText)
            .map(filterSearchText)
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
