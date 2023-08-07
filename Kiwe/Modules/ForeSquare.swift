//
//  ForeSquare.swift
//  Kiwe
//
//  Created by Ziad Alfakharany on 07/08/2023.
//

import Foundation

public struct Result: Codable {
    let fsq_id: String
    let categories: [Category]
    let census_block_id: String
    let chains: [Chain]
    let date_closed: String
    let description: String
    let distance: Int
    let email: String
    let fax: String
    let features: Features
    let geocodes: Geocodes
    let hours: Hours
    let hours_popular: [HoursPopular]
    let location: Location
    let menu: String
    let name: String
    let photos: [Photo]
    let popularity: Int
    let price: Int
    let rating: Int
    let related_places: RelatedPlaces
    let social_media: SocialMedia
    let stats: Stats
    let tastes: [String]
    let tel: String
    let timezone: String
    let tips: [Tip]
    let verified: Bool
    let website: String
}

struct Category: Codable {
    let id: Int
    let name: String
    let icon: Icon
}

struct Icon: Codable {
    let id: String
    let created_at: String
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
    let classifications: [String]
    let tip: Tip
}

struct Tip: Codable {
    let id: String
    let created_at: String
    let text: String
    let url: String
    let lang: String
    let agree_count: Int
    let disagree_count: Int
}

struct Chain: Codable {
    let id: String
    let name: String
}

struct Features: Codable {
    let payment: Payment
    let food_and_drink: FoodAndDrink
    let services: Services
    let amenities: Amenities
}

struct Payment: Codable {
    let credit_cards: CreditCards
    let digital_wallet: DigitalWallet
}

struct CreditCards: Codable {
    let accepts_credit_cards: [String: String]
    let discover: [String: String]
    let visa: [String: String]
    let diners_club: [String: String]
    let master_card: [String: String]
}

struct DigitalWallet: Codable {
    let accepts_nfc: [String: String]
}

struct FoodAndDrink: Codable {
    let alcohol: Alcohol
    let meals: Meals
}

struct Alcohol: Codable {
    let beer: [String: String]
    let byo: [String: String]
    let cocktails: [String: String]
    let full_bar: [String: String]
    let wine: [String: String]
}

struct Meals: Codable {
    let breakfast: [String: String]
    let brunch: [String: String]
    let lunch: [String: String]
    let happy_hour: [String: String]
    let dessert: [String: String]
    let dinner: [String: String]
}

struct Services: Codable {
    let delivery: [String: String]
    let takeout: [String: String]
    let drive_through: [String: String]
    let dine_in: DineIn
}

struct DineIn: Codable {
    let reservations: [String: String]
    let online_reservations: [String: String]
    let groups_only_reservations: [String: String]
}

struct Amenities: Codable {
    let restroom: [String: String]
    let smoking: [String: String]
    let jukebox: [String: String]
    let music: [String: String]
    let live_music: [String: String]
    let private_room: [String: String]
    let outdoor_seating: [String: String]
    let tvs: [String: String]
    let atm: [String: String]
    let coat_check: [String: String]
    let wheelchair_accessible: [String: String]
    let parking: Parking
}

struct Parking: Codable {
    let parking: [String: String]
    let street_parking: [String: String]
    let valet_parking: [String: String]
    let public_lot: [String: String]
    let private_lot: [String: String]
}

struct Geocodes: Codable {
    let drop_off: Geocode
    let front_door: Geocode
    let main: Geocode
    let road: Geocode
    let roof: Geocode
}

struct Geocode: Codable {
    let latitude: Int
    let longitude: Int
}

struct Hours: Codable {
    let display: String
    let is_local_holiday: Bool
    let open_now: Bool
    let regular: [Regular]
}

struct Regular: Codable {
    let close: String
    let day: Int
    let open: String
}

struct HoursPopular: Codable {
    let close: String
    let day: Int
    let open: String
}

struct Location: Codable {
    let address: String
    let address_extended: String
    let admin_region: String
    let country: String
    let cross_street: String
    let dma: String
    let formatted_address: String
    let locality: String
    let po_box: String
    let post_town: String
    let postcode: String
    let region: String
}

struct Photo: Codable {
    let id: String
    let created_at: String
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
    let classifications: [String]
    let tip: Tip
}

struct RelatedPlaces: Codable {
    let children: [String?]
}

struct SocialMedia: Codable {
    let facebook_id: String
    let instagram: String
    let twitter: String
}

struct Stats: Codable {
    let total_photos: Int
    let total_ratings: Int
    let total_tips: Int
}
