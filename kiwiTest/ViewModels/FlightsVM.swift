//
//  FlightsVM.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 19.4.21..
//

import Foundation

struct FlightsVM {
    
    let numberOfFlightsOfInterest = 5
    let errMsg = "There are no current destiantions available!"
    
    var isFetchingInProgress = true
    
    var title: String {
        return isFetchingInProgress ? "Fetching...." : "Top 5 destinations!"
    }
}
