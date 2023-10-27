

import Foundation

// MARK: - ExperiencesRequest
struct ExperiencesRequest: Codable {
    let meta: Meta?
    let data: [Datum]?
    let pagination: Pagination?
}

// MARK: - Datum
struct Datum: Codable {
    let id, title: String?
    let coverPhoto: String?
    let description: String?
    let viewsNo, likesNo, recommended, hasVideo: Int?
    let tags: [City]?
    let city: City?
    let tourHTML: String?
    let famousFigure: String?
    let period, era: Era?
    let founded, detailedDescription, address: String?
    let gmapLocation: GmapLocation?
    
    let startingPrice: Int?
    let ticketPrices: [TicketPrice]?
    
    
    let rating, reviewsNo: Int?
    let audioURL: String?
    let hasAudio: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title
        case coverPhoto = "cover_photo"
        case description
        case viewsNo = "views_no"
        case likesNo = "likes_no"
        case recommended
        case hasVideo = "has_video"
        case tags, city
        case tourHTML = "tour_html"
        case famousFigure = "famous_figure"
        case period, era, founded
        case detailedDescription = "detailed_description"
        case address
        case gmapLocation = "gmap_location"
        
        case startingPrice = "starting_price"
        case ticketPrices = "ticket_prices"
        
        case rating
        case reviewsNo = "reviews_no"
        case audioURL = "audio_url"
        case hasAudio = "has_audio"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    
    let topPick: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case topPick = "top_pick"
    }
}

// MARK: - Era
struct Era: Codable {
    let id, value, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, value
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - GmapLocation
struct GmapLocation: Codable {
    let type: String?
    let coordinates: [Double]?
}



enum Time: String, Codable {
    case the07001600 = "07:00-16:00"
    case the09000400 = "09:00-04:00"
    case the09001200 = "09:00-12:00"
    case the09001600 = "09:00-16:00"
    case the09001700 = "09:00-17:00"
    case the09001900 = "09:00-19:00"
}

// MARK: - TicketPrice
struct TicketPrice: Codable {
    let type: String?
    let price: Int?
}

// MARK: - TranslatedOpeningHours
struct TranslatedOpeningHours: Codable {
    let sunday, monday, tuesday, wednesday: Day?
    let thursday, friday, saturday: Day?
}

// MARK: - Day
struct Day: Codable {
    let day: String?
    let time: Time?
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    
}

// MARK: - Pagination
struct Pagination: Codable {
}





