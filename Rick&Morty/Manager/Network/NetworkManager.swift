//
//  NetworkManager.swift
//  Rick&Morty
//
//  Created by Nikita on 02.03.2024.
//

import Foundation

protocol LoadedInformation {
    
    func transitData(_ networkManager: NetworkManager, data: [Results])
}

class NetworkManager {
    
    //MARK: - Propertie
    
    static let shared = NetworkManager()
    let session = URLSession(configuration: .default)
    let decoder = JSONDecoder()
    var delegate: LoadedInformation?
    
    //MARK: - Method
    
    func fetchData(url: URLRequest) {
            session.dataTask(with: url) { [weak self] data, response, error in
                guard let data else {
                    if error != nil {
                        print(NetworkError.badRequst)
                    }
                    return
                }
                
                do {
                    guard let baseData = try self?.decoder.decode(Characters.self, from: data) else { return }
                    let characters = baseData.results.map({ $0 })
                    self?.delegate?.transitData(self!, data: characters)
                } catch {
                    print(NetworkError.badResponse)
                }
            }.resume()
    }
    
    func loadMoreData(url: URLRequest) {
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let data else {
                if error != nil {
                    print(NetworkError.badRequst)
                }
                return
            }
            do {
                guard let baseData = try self?.decoder.decode(Info.self, from: data) else { return }
                let characters = baseData.results.map({ $0 })
                self?.delegate?.transitData(self!, data: characters)
            } catch {
                print(error.localizedDescription)
                print(NetworkError.badResponse)
            }
        }.resume()
    }
    
    func loadEpisodesData(episodes: [String], completion: @escaping ([Episodes]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var episodesArray = [Episodes]()
        
        episodes.forEach { item in
            guard let episodeUrl = URL(string: item) else { return }
            
            dispatchGroup.enter()
            
            session.dataTask(with: episodeUrl) { data, response, error in
                
                defer {
                    dispatchGroup.leave()
                }
                
                guard let data else {
                    if error != nil {
                        print(NetworkError.badRequst)
                    }
                    return
                }
                
                do {
                    let episodesData = try self.decoder.decode(Episodes.self, from: data)
                    episodesArray.append(episodesData)
                } catch {
                    print(NetworkError.badResponse)
                }
            }.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(episodesArray)
        }
    }
}

enum NetworkError: Error {
    case badUrl
    case badRequst
    case badResponse
}
