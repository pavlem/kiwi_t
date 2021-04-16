//
//  FlightInfoService.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 18.4.21..
//

import UIKit

class FlightInfoService: NetworkService {
    
    // MARK: - API
    func fetchFlightToImage(imageName: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) -> URLSessionDataTask? {
        
        guard let url = URL(string: "\(scheme)\(imageHost)\(imageName).jpg") else { return nil }
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(NetworkError.error(err: err)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            guard let img = UIImage(data: data) else {
                completion(.failure(.unknown))
                return
            }
            
            completion(.success(img))
        }
        task.resume()
        return task
    }
    
    func fetchFlights(flightRequest: FlightRequest, completion: @escaping (Result<[FlightResponse], NetworkError>) -> ()) -> URLSessionDataTask? {
        
        return fetch(urlString: urlString, path: self.path, method: .get, params: flightRequest.body(), headers: nil) { (result: Result<FlightResponseDictionary, NetworkError>) in
            
            switch result {
            case .success(let flightDictionary):
                let flights = flightDictionary.data
                completion(.success(flights))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    // MARK: - Properties
    private let scheme = "https://"
    private let host = "api.skypicker.com/"
    private let imageHost = "images.kiwi.com/photos/600x330/"
    private let path = "flights"
    private var urlString: String {
        return scheme + host
    }
}
