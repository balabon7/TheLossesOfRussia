//
//  Model.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//


import Foundation

// MARK: - Personnel
struct Personnel: Codable {
    let date: String?
    let day, personnel: Int?
    let personnelDetails: PersonnelDetails?
    let pow: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case personnelDetails = "personnel*"
        case pow = "POW"
    }
}

// MARK: - PersonnelDetails
enum PersonnelDetails: String, Codable {
    case about = "about"
    case more = "more"
}
