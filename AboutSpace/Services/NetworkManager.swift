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
    
    //загрузка картинки
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
       //url
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        //создаем экземпляр imageData
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            //возвращаем в основной поток полученную картинку
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    //универсальный метод загрузки
    //Т - тип, который должен будет вернуть метод
    func fetch<T: Decodable>(dataType: T.Type, from url: String, convertFromSnakeCase: Bool = true, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                if convertFromSnakeCase {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                }
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
