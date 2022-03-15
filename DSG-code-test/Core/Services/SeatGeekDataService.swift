//
//  SeatGeekDataService.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//
// URL: https://api.seatgeek.com/2/events?client_id=MjYxMDY4NTd8MTY0NzI3NjI5Ni44OTcxMDE0&q=swift
// Client ID: MjYxMDY4NTd8MTY0NzI3NjI5Ni44OTcxMDE0


import Foundation
import Combine



class SeatGeekDataService {
    @Published var welcome: Welcome?
    @Published var events: [Event] = []
    
    var seatGeekSubscription: AnyCancellable?
    
    var searchPrefix = "&q="
    
    
    func getEvents(text: String) {
        
        var urlString: String = "https://api.seatgeek.com/2/events?client_id=MjYxMDY4NTd8MTY0NzI3NjI5Ni44OTcxMDE0"
        
        if !text.isEmpty {
            urlString = urlString + searchPrefix + text
        }
        
        
        guard let url = URL(string: urlString) else { return }
        
        seatGeekSubscription = NetworkingManager.download(url: url)
            .decode(type: Welcome.self, decoder: JSONDecoder())

            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedModel) in
//                print("Returned Model: \(returnedModel)")
                self?.welcome = returnedModel
                
                var newArray:[Event] = []

                if let array = self?.welcome?.events {
                    for object in array {
                        let newEvent = Event(id: object.id,
                                             datetimeUTC: object.datetimeUTC,
                                             venue: object.venue,
                                             performers: object.performers,
                                             datetime_local: object.datetime_local,
                                             url: object.url,
                                             title: object.title,
                                             popularity: object.popularity,
                                             description: object.description)
                        
                        newArray.append(newEvent)
                    }
                    self?.events = newArray

                }
                
                self?.seatGeekSubscription?.cancel()
     
            })
        
        
    }
    

    
}
