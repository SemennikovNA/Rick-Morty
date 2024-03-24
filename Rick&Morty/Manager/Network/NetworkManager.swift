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
    
    func fetchData(url: URLRequest, isPage: Bool = false, pageNumber: Int = 0) {
        guard isPage else {
            session.dataTask(with: url) { [weak self] data, response, error in
                guard let data else {
                    if error != nil {
                        print(NetworkError.badRequst)
                    }
                    return
                }
                
                do {
                    guard let baseData = try self?.decoder.decode(Charac.self, from: data) else { return }
                    var characters: [Charac] = []
                    characters.append(baseData)
                    self?.delegate?.transitData(self!, data: characters)
                } catch {
                    print(NetworkError.badResponse)
                }
            }.resume()
            return
        }
        
        let pageUrl = "\(url)\(pageNumber)"
        print(pageUrl)
        
    }
}

enum NetworkError: Error {
    case badUrl
    case badRequst
    case badResponse
}
