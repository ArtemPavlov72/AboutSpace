//
//  RoverPhoto.swift
//  AboutSpace
//
//  Created by iMac on 20.10.2021.
//

import Foundation

struct RoverPhoto: Decodable {
    let photos: [MarsRoverPhoto]?
}

struct MarsRoverPhoto: Decodable {
    let id: Int?
    let sol: Int?
    let imgSrc: String?
    let earthDate: String?
    let rover: RoverSpecs?
}

struct RoverSpecs: Decodable {
    let name: String?
    let landingDate: String?
    let status: String?
}
