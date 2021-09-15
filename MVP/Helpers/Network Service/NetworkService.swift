//
//  NetworkService.swift
//  MVP
//
//  Created by Илья Москалев on 16.09.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getComments(completion: @escaping (Result<Comments?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getComments(completion: @escaping (Result<Comments?, Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/comments"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let object = try JSONDecoder().decode(Comments.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error!))
            }
        }.resume()
    }
}
