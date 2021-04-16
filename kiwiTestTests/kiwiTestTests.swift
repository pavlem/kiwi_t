//
//  kiwiTestTests.swift
//  kiwiTestTests
//
//  Created by Pavle Mijatovic on 15.4.21..
//

import XCTest
@testable import kiwiTest

class kiwiTestTests: XCTestCase {
    
    // FlightsVM
    func testFlightsVM() {
        let vm1 = FlightsVM(isFetchingInProgress: true)
        XCTAssert(vm1.title == "Fetching....")
        let vm2 = FlightsVM(isFetchingInProgress: false)
        XCTAssert(vm2.title == "Top 5 destinations!")
        let vm3 = FlightsVM()
        XCTAssert(vm3.title == "Fetching....")
    }
    
    // FlightVM
    func testGetNumberOfStops() {
        XCTAssert(FlightVM.getNumberOfStops(fromRouteCount: 1) == "Direct flight")
        XCTAssert(FlightVM.getNumberOfStops(fromRouteCount: 2) == "Stops: 1")
        XCTAssert(FlightVM.getNumberOfStops(fromRouteCount: 3) == "Stops: 2")
    }
    
    func testGetFormatedDate() {
        XCTAssert(FlightVM.getFormatedDate(dateTimestamp: 1618918800.0) == "20/04/2021 13:40")
        XCTAssert(FlightVM.getFormatedDate(dateTimestamp: 1619091600.0) == "22/04/2021 13:40")
    }
    
    func testGetFirstNFlights() {
        let f1 = FlightVM(destionationName: "", from: "", date: "", distance: "", destionationUrlString: "", destinationToImageName: "")
        let f2 = FlightVM(destionationName: "", from: "", date: "", distance: "", destionationUrlString: "", destinationToImageName: "")
        let f3 = FlightVM(destionationName: "", from: "", date: "", distance: "", destionationUrlString: "", destinationToImageName: "")
        let f4 = FlightVM(destionationName: "", from: "", date: "", distance: "", destionationUrlString: "", destinationToImageName: "")
        let f5 = FlightVM(destionationName: "", from: "", date: "", distance: "", destionationUrlString: "", destinationToImageName: "")
        let f6 = FlightVM(destionationName: "", from: "", date: "", distance: "", destionationUrlString: "", destinationToImageName: "")
        
        let flights1 = [f1, f2, f3, f4, f5, f6]
        let flightCount1 = FlightVM.getFirst(n: 2, from: flights1)
        let flightCount2 = FlightVM.getFirst(n: 4, from: flights1)
        let flightCount3 = FlightVM.getFirst(n: 10, from: flights1)

        XCTAssert(flightCount1?.count == 2)
        XCTAssert(flightCount2?.count == 4)
        XCTAssert(flightCount3?.count == 6)
    }
    
    func testFlightsCount() {
        let asyncExpectation = expectation(description: "Async block executed")

        kiwiTestTests.fetchMOCFlights { (flightResponseDict) in
            XCTAssert(flightResponseDict.data.count == 45)
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFlightVM() {
        let asyncExpectation = expectation(description: "Async block executed")

        kiwiTestTests.fetchMOCFlights { (flightResponseDict) in
            let flightResponse = flightResponseDict.data.first!
            let flightVM = FlightVM(flight: flightResponse)
           
            XCTAssert(flightVM.destionationName == "Dubai - 169 €")
            XCTAssert(flightVM.from == "From: Vienna")
            XCTAssert(flightVM.date == "Date: 22/04/2021 13:40")
            XCTAssert(flightVM.distance == "Distance: 4226.97 km, Stops: 1")
            XCTAssert(flightVM.destionationName == "Dubai - 169 €")
            
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Helper
    static func fetchMOCFlights(delay: Int = 0, completion: @escaping (FlightResponseDictionary) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            let filePath = "flightsMOC"
            loadJsonDataFromFile(filePath, completion: { data in
                if let json = data {
                    do {
                        let products = try JSONDecoder().decode(FlightResponseDictionary.self, from: json)
                        completion(products)
                    } catch _ as NSError {
                        fatalError("Couldn't load data from \(filePath)")
                    }
                }
            })
        }
    }

    static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(data as Data)
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
