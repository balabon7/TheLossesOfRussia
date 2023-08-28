//
//  NetworkService.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//

import Foundation

class NetworkService {
    
    // MARK: - Properties
    let baseString: String = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data"
    
    // MARK: - Helper Functions
    private func getLossesURL(for lossType: RussiaLosses) -> URL? {
        guard let baseURL: URL = URL(string: baseString) else { return nil }
        return baseURL.appendingPathComponent(lossType.stringValue())
    }
    
    // MARK: - Network Errors
    enum NetworkError: Error {
        case invalidURL
        case noData
        case invalidDataFormat
    }
    
    // MARK: - Typealiases
    typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> Void
    
    // MARK: - Data Fetching
    func fetchData<T: Decodable>(for lossType: RussiaLosses, completion: @escaping CompletionHandler<T>) {
        
        guard let url = getLossesURL(for: lossType) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            if let result = try? decoder.decode(T.self, from: data) {
                completion(.success(result))
            } else if let resultArray = try? decoder.decode([T].self, from: data) as? T {
                completion(.success(resultArray))
            } else {
                completion(.failure(NetworkError.invalidDataFormat))
            }
        }
        
        task.resume()
    }
}
