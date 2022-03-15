//
//  SeatGeekModel.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

// MARK: API Information
// URL: https://api.seatgeek.com/2/events?client_id=MjYxMDY4NTd8MTY0NzI3NjI5Ni44OTcxMDE0&q=swift
// Client ID: MjYxMDY4NTd8MTY0NzI3NjI5Ni44OTcxMDE0

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let events: [Event]?
    let meta: Meta
}

// MARK: - Event
struct Event: Codable, Hashable, Equatable {
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id ?? 0 > rhs.id ?? 1
    }
    
//    let type: NameEnum
    let id: Int?
    let datetimeUTC: String?
    let venue: Venue?
//    let datetimeTbd: Bool
    let performers: [Performer]?
//    let isOpen: Bool
//    let links: [Any?]
    let datetime_local: String
//    let timeTbd: Bool
//    let shortTitle, visibleUntilUTC: String
//    let stats: EventStats
//    let taxonomies: [Taxonomy]
    let url: String?
//    let score: Double
//    let announceDate, createdAt: String
//    let dateTbd: Bool
    let title: String?
    let popularity: Double?
    let description: String?
//    let status: Status
//    let accessMethod: AccessMethod?
//    let eventPromotion: NSNull
//    let announcements: Announcements
//    let conditional: Bool
//    let enddatetimeUTC: NSNull
//    let themes, domainInformation: [Any?]
//    enum CodingKeys: String, CodingKey {
//        case datetimeUTC = "datetime_utc"
//    }

}

// MARK: - AccessMethod
struct AccessMethod {
    let method: String
    let createdAt: Date
    let employeeOnly: Bool
}

// MARK: - Announcements
struct Announcements {
}

// MARK: - Performer
struct Performer: Codable, Hashable, Equatable {
    static func == (lhs: Performer, rhs: Performer) -> Bool {
        return lhs.id > rhs.id
    }
    
    
//    let type: PerformerType
    let name: String
    let image: String
    let id: Int
    let images: PerformerImages?
//    let divisions: NSNull
//    let hasUpcomingEvents: Bool
//    let primary: Bool?
//    let stats: PerformerStats
//    let taxonomies: [Taxonomy]
    let imageAttribution, url: String?
    let score: Double?
    let slug: String?
//    let homeVenueID: NSNull
    let shortName: String?
//    let numUpcomingEvents: Int
//    let colors: NSNull
//    let imageLicense: String
//    let popularity: Int
//    let location: NSNull
//    let imageRightsMessage: String
//    let homeTeam, awayTeam: Bool?
//    let genres: [Genre]?
}

// MARK: - Genre
struct Genre {
    let id: Int
    let name, slug: String
    let primary: Bool
    let images: GenreImages
    let image: String
//    let documentSource: DocumentSource
}

// MARK: - DocumentSource
//struct DocumentSource {
//    let sourceType: SourceType
//    let generationType: GenerationType
//}

enum GenerationType {
    case full
}

enum SourceType {
    case elastic
}

// MARK: - GenreImages
struct GenreImages {
    let the1200X525, the1200X627, the136X136, the500_700: String
    let the800X320, banner, block, criteo130_160: String
    let criteo170_235, criteo205_100, criteo400_300, fb100X72: String
    let fb600_315, huge, ipadEventModal, ipadHeader: String
    let ipadMiniExplore, mongo, squareMid, triggitFbAd: String
}

// MARK: - PerformerImages
struct PerformerImages: Codable, Hashable {
    let huge: String?
}

// MARK: - PerformerStats
struct PerformerStats {
    let eventCount: Int
}

// MARK: - Taxonomy
struct Taxonomy {
    let id: Int
//    let name: NameEnum
    let parentID: Int?
//    let documentSource: DocumentSource?
    let rank: Int
}

//enum NameEnum {
//    case concert
//    case concerts
//    case fighting
//    case hockey
//    case sports
//    case wrestling
//}

enum PerformerType {
    case band
    case hockey
    case wrestling
}

// MARK: - EventStats
struct EventStats {
    let listingCount, averagePrice, lowestPriceGoodDeals, lowestPrice: Int?
    let highestPrice, visibleListingCount: Int?
    let dqBucketCounts: [Int]?
    let medianPrice, lowestSgBasePrice, lowestSgBasePriceGoodDeals: Int?
}

enum Status {
    case normal
}

// MARK: - Venue
struct Venue: Codable, Hashable {
    let state, nameV2, postalCode, name: String?
    let timezone: String?
    let url: String?
    let score: Double?
//    let location: Location?
    let address: String?
//    let country: Country?
//    let hasUpcomingEvents: Bool
//    let numUpcomingEvents: Int
    let city, slug, extendedAddress: String?
//    let id, popularity: Int
//    let metroCode, capacity: Int
    let displayLocation: String?
}

//enum Country: Codable {
//    case canada
//    case us
//}

// MARK: - Location
struct Location: Codable {
    let lat, lon: Double
}

// MARK: - Meta
struct Meta: Codable {
    let total, took, page, perPage: Int?
//    let geolocation: NSNull
}
