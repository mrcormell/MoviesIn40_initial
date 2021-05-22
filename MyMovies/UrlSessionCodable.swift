//
//  URLSession-Codable.swift
//  MyMovies
//
//  Created by David Cormell on 13/05/2021.
//

import Foundation

extension URLSession {
    func get<T: Decodable>(path: String, queryItems: [String: String] = [:], defaultValue: T, completion: @escaping (T) -> Void) {
        
        guard var components = URLComponents(string: "https://api.themoviedb.org/3/\(path)") else {
            return
        }
        
        components.queryItems = [URLQueryItem(name: "api_key", value: "d92af22de81f1378f89e28b683cbfd79")] + queryItems.map(URLQueryItem.init)
        
        if let url = components.url {
            let urlRequest = URLRequest(url: url)
            self.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let decodedResponse = try? decoder.decode(T.self, from: data) {
                        completion(decodedResponse)
                    }
                }
            }
            .resume()
        }
    }
}

