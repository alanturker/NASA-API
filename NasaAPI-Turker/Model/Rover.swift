//
//  Rover.swift
//  NasaAPI-Turker
//
//  Created by Gülşah Alan on 28.09.2021.
//

import Foundation

struct RoverResponse: Codable {
    let photos: [Rover]
    
    private enum CodingKeys: String, CodingKey {
        case photos
    }
}

struct Rover: Codable {
    let camera: CameraInfo
    let img_src: String?
    let rover: RoverInfo
    let earth_date: String?
    
    private enum CodingKeys: String, CodingKey {
        case camera, img_src, rover, earth_date
    }
}

struct CameraInfo: Codable {
    let id: Int?
    let name: String?
    let rover_id: Int?
    let full_name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, rover_id, full_name
    }
}

struct RoverInfo: Codable {
    let id: Int?
    let name: String?
    let landing_date: String?
    let launch_date: String?
    let status: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, landing_date, launch_date, status
    }
}


