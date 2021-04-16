//
//  NetError.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 18.4.21..
//

import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
    case jsonDecodeErr(description: String)
    case pageNotFound
    case clientRelated
    case serverRelated
    case noResponse
    case error(err: Error)
    case notAnImage
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad URL"
        case .requestFailed:
            return "Request Failed"
        case .unknown:
            return "Unknown"
        case .jsonDecodeErr(description: let err):
            return err
        case .pageNotFound:
            return "Page Not Found"
        case .clientRelated:
            return "Page Not Found"
        case .serverRelated:
            return "Page Not Found"
        case .noResponse:
            return "Page Not Found"
        case .notAnImage:
            return "Not An Image"
        case .error(err: let err):
            return err.localizedDescription
        }
    }
}
