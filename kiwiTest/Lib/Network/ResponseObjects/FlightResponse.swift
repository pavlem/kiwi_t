//
//  FlightResponse.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 17.4.21..
//

import Foundation

struct FlightResponse: Decodable {
    
    struct FlightRouteResponse: Decodable {
        let cityFrom: String
        let cityCodeFrom: String
        let cityTo: String
        let cityCodeTo: String
    }
    
    let cityFrom: String
    let cityCodeFrom: String
    let cityTo: String
    let cityCodeTo: String
    let deepLink: String
    let mapIdto: String
    let dTimeUTC: Double
    let price: Int
    let route: [FlightRouteResponse]
    let distance: Double
    
    enum CodingKeys: String, CodingKey {
        case cityFrom, cityCodeFrom, cityTo, cityCodeTo, mapIdto, dTimeUTC, price, route, distance
        case deepLink = "deep_link"
    }
}
