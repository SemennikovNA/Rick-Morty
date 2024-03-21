//
//  NetworkManager.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import Foundation

protocol LoadedInformation {
    
    func transitData(_ networkManager: NetworkManager, data: [Charac])
}

class NetworkManager {
    
    //MARK: - Propertie
    
    static let shared = NetworkManager()
    let session = URLSession(configuration: .default)
    let decoder = JSONDecoder()
    var delegate: LoadedInformation?
    
    //MARK: - Method
    
    func createURL() -> URL? {
        let tunnel = "https://"
        let mainUrl = "rickandmortyapi.com/"
        let api = "api"
        let getKey = "/character"
        let url = tunnel + mainUrl + api + getKey
        return  URL(string: url)
    }
    
    func fetchData() {
        guard let url = createURL() else {
            return
        }
        
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let data else {
                if error != nil {
                    print(String(describing: error?.localizedDescription))
                }
                return
            }
            
            do {
                guard let baseData = try self?.decoder.decode(Charac.self, from: data) else { return }
                var characters: [Charac] = []
                characters.append(baseData)
                self?.delegate?.transitData(self!, data: characters)
            } catch {
                print(String(describing: error.localizedDescription))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case badUrl
    case badRequst
    case badResponse
}
