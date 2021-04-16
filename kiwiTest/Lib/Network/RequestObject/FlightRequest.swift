//
//  FlightRequest.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 17.4.21..
//

import Foundation

struct FlightRequest: Encodable {
    let v: String = "3"
    let sort: String = "popularity"
    let asc: String = "0"
    let locale: String = "en"
    let daysInDestinationFrom: String = ""
    let daysInDestinationTo: String = ""
    let children: String = "0"
    let infants: String = "0"
    let flyFrom: String = "49.2-16.61-250km"
    let to: String = "anywhere"
    let featureName: String = "aggregateResults"
    let dateFrom: String = getDateFrom
    let dateTo: String = getDateTo
    let typeFlight: String = "oneway"
    let returnFrom: String = ""
    let returnTo: String = ""
    let one_per_date: String = "0"
    let oneforcity: String = "1"
    let wait_for_refresh: String = "0"
    let adults: String = "1"
    let limit: String = "45"
    let partner: String = "picky"
}

extension FlightRequest {
    static var getDateFrom: String {
        return getDateAsString()
    }
    
    static var getDateTo: String {
        return getDateAsString()
    }
    
    static func getDateAsString() -> String {
        var today = Date()
        today = today.addingTimeInterval(3600*24*3) // this was added to see the flights from the day after
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: today)
    }
}

extension FlightRequest {
    func body() -> NetworkService.JSON {
        let params: [String: Any] = [
            "v": self.v,
            "sort": self.sort,
            "asc": self.asc,
            "locale": self.locale,
            "daysInDestinationFrom": self.daysInDestinationFrom,
            "daysInDestinationTo": self.daysInDestinationTo,
            "children": self.children,
            "infants": self.infants,
            "flyFrom": self.flyFrom,
            "to": self.to,
            "featureName": self.featureName,
            "dateFrom": self.dateFrom,
            "dateTo": self.dateTo,
            "typeFlight": self.typeFlight,
            "returnFrom": self.returnFrom,
            "returnTo": self.returnTo,
            "one_per_date": self.one_per_date,
            "oneforcity": self.oneforcity,
            "wait_for_refresh": self.wait_for_refresh,
            "adults": self.adults,
            "limit": self.limit,
            "partner": self.partner,
        ]
        return params
    }
}
