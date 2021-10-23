//
//  NetworkManager.swift
//  AboutSpace
//
//  Created by iMac on 22.10.2021.
//

import Foundation

//ссылки, где хранятся данные json
enum Link: String {
    case imageURL = "https://apod.nasa.gov/apod/image/2109/RedSquare_Tuthill_960.jpg"
    case marsRoverPhotos = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=DEMO_KEY"
}

//перечисление ошибок для NetworkError
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
