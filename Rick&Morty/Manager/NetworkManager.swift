//
//  NetworkManager.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case badRequst
    case badResponse
}

class NetworkManager {
    
    //MARK: - Propertie
    
    static let shared = NetworkManager()
    let session = URLSession(configuration: .default)
    let decoder = JSONDecoder()
    
    //MARK: - Method
    // https://rickandmortyapi.com/api
    
    func createURL() -> URL? {
        let tunnel = "https://"
        let mainUrl = "rickandmortyapi.com/"
        let api = "api"
        let url = tunnel + mainUrl + api
        return  URL(string: url)
    }
    
    func fetchData(completion: @escaping(Result<BaseApiResponse, Error>) -> ()) {
        guard let url = createURL() else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            guard let data else {
                if error != nil {
                    completion(.failure(NetworkError.badResponse))
                }
                return
            }
            
            do {
                let baseData = try self.decoder.decode(BaseApiResponse.self, from: data)
                print(baseData.characters, baseData.episodes, baseData.locations)
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
