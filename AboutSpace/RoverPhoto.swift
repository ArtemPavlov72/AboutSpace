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
    let img_src: String?
    let earth_date: String?
    let rover: RoverSpecs?
}

struct RoverSpecs: Decodable {
    let name: String?
    let landing_date: String?
    let status: String?
}
