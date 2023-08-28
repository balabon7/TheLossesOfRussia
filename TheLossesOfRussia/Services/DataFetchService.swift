//
//  DataFetchService.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//

import Foundation

class DataFetchService {
    
    // MARK: - Properties
    private let networkManager = NetworkService()
    
    // MARK: - Public API
    func getEquipmentData(completion: @escaping (Result<[Equipment], Error>) -> Void) {
        fetchData(for: .equipment, completion: completion)
    }
    
    func getEquipmentCorrectionData(completion: @escaping (Result<[EquipmentCorrection], Error>) -> Void) {
        fetchData(for: .equipmentCorrection, completion: completion)
    }
    
    func getEquipmentOryxData(completion: @escaping (Result<[EquipmentOryx], Error>) -> Void) {
        fetchData(for: .equipmentOryx, completion: completion)
    }
    
    func getPersonnelData(completion: @escaping (Result<[Personnel], Error>) -> Void) {
        fetchData(for: .personnel, completion: completion)
    }
    
    // MARK: - Private Helpers
    private func fetchData<T: Decodable>(for lossType: RussiaLosses, completion: @escaping (Result<[T], Error>) -> Void) {
        networkManager.fetchData(for: lossType) { (result: Result<[T], Error>) in
            switch result {
            case .success(let array):
                completion(.success(array))
            case .failure(let error):
                print("Error fetching data:", error)
                completion(.failure(error))
            }
        }
    }
}
