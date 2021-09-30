//
//  API.swift
//  NasaAPI-Turker
//
//  Created by Gülşah Alan on 28.09.2021.
//

import Foundation
import Moya

enum NasaAPI {
    case curiosity(page: Int)
    case opportunity(page: Int)
    case spirit(page: Int)
}

fileprivate let apiKey = "JzCKeyNn3NW5nE0OPF0Dzfc4a5BYr5XTP2Sapdyl"
fileprivate let urlNasa = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
fileprivate let sol = "1000"

extension NasaAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: urlNasa) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .curiosity(_):
            return "curiosity/photos"
        case .opportunity(_):
            return "opportunity/photos"
        case .spirit(_):
            return "spirit/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .curiosity(_), .opportunity(_), .spirit(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .curiosity(page: let page), .opportunity(page: let page), .spirit(page: let page):
            return .requestParameters(parameters: ["sol": sol, "page": page, "api_key": apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
