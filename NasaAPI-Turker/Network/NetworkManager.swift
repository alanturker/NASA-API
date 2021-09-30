//
//  NetworkManager.swift
//  NasaAPI-Turker
//
//  Created by Gülşah Alan on 29.09.2021.
//

import Foundation
import Moya

final class NetworkManager {
    
    var provider = MoyaProvider<NasaAPI>(plugins: [NetworkLoggerPlugin()])
    
    typealias nasaCompletion = ([Rover]) -> ()
    
    func fetchCuriosityPhotos(page: Int, completionHandler: @escaping nasaCompletion) {
        provider.request(.curiosity(page: page)) { photoResponse in
            switch photoResponse {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(RoverResponse.self, from: response.data)
                    completionHandler(results.photos)
                } catch let responseError {
                    print("responseError: \(responseError)")
                }
            case .failure(let servereError):
                print("serverError: \(servereError)")
            }
            
        }
    }
    
    
    func fetchOpportunityPhotos(page: Int, completionHandler: @escaping nasaCompletion) {
        provider.request(.opportunity(page: page)) { photoResponse in
            switch photoResponse {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(RoverResponse.self, from: response.data)
                    completionHandler(results.photos)
                } catch let responseError {
                    print("responseError: \(responseError)")
                }
            case .failure(let servereError):
                print("serverError: \(servereError)")
            }
            
        }
    }
    
    
    func fetchSpiritPhotos(page: Int, completionHandler: @escaping nasaCompletion) {
        provider.request(.spirit(page: page)) { photoResponse in
            switch photoResponse {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(RoverResponse.self, from: response.data)
                    completionHandler(results.photos)
                } catch let responseError {
                    print("responseError: \(responseError)")
                }
            case .failure(let servereError):
                print("serverError: \(servereError)")
            }
            
        }
    }
}


