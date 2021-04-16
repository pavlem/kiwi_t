//
//  FlightVM.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 16.4.21..
//

import UIKit

struct FlightVM {
    let destionationName: String
    let from: String
    let date: String
    let distance: String
    let destionationUrlString: String
    let destinationToImageName: String
    
    let backGroundColor = UIColor.lightText
    
    static let buyBtnTitle = "BUY"
}

extension FlightVM {
    init(flight: FlightResponse) {
        destionationName = flight.cityTo + " - \(flight.price) €"
        from = "From: " + flight.cityFrom
        date = "Date: " + FlightVM.getFormatedDate(dateTimestamp: flight.dTimeUTC)
        distance = "Distance: " + String(flight.distance) + " km" + ", " + FlightVM.getNumberOfStops(fromRouteCount: flight.route.count)
        destionationUrlString = flight.deepLink
        destinationToImageName = flight.mapIdto
    }
}

extension FlightVM {
    static func getFirst(n: Int, from flights: [FlightVM]) -> [FlightVM]? {
        if flights.count >= n {
            return Array(flights[0...n-1])
        } else {
            return Array(flights[0...flights.count-1])
        }
    }
    
    static func getFormatedDate(dateTimestamp: Double) -> String {
        let myDate = Date(timeIntervalSince1970: TimeInterval(dateTimestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: myDate)
    }
    
    static func getNumberOfStops(fromRouteCount routeCount: Int) -> String {
        return routeCount > 1 ? "Stops: \(routeCount - 1)" : "Direct flight"
    }
}
