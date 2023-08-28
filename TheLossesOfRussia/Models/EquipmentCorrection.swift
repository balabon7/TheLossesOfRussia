//
//  EquipmentCorrection.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//


import Foundation

// MARK: - Equipment Correction
struct EquipmentCorrection: Codable {
    
    let date: String?
    let day, aircraft, helicopter, tank: Int?
    let apc, fieldArtillery, mrl, drone: Int?
    let navalShip, antiAircraftWarfare, specialEquipment, vehiclesAndFuelTanks: Int?
    let cruiseMissiles: Int?

    enum CodingKeys: String, CodingKey {
        case date, day, aircraft, helicopter, tank
        case apc = "APC"
        case fieldArtillery = "field artillery"
        case mrl = "MRL"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
    }

    static func formattedLabelName(for label: String) -> String {
        switch label {
        case "date": return "Date"
        case "day": return "Day"
        case "aircraft": return "Aircraft"
        case "helicopter": return "Helicopter"
        case "tank": return "Tank"
        case "apc": return "APC"
        case "fieldArtillery": return "Field artillery"
        case "mrl": return "MRL"
        case "drone": return "Drone"
        case "navalShip": return "Naval ship"
        case "antiAircraftWarfare": return "Anti-aircraft warfare"
        case "specialEquipment": return "Special equipment"
        case "vehiclesAndFuelTanks": return "Vehicles and fuel tanks"
        case "cruiseMissiles": return "Cruise missiles"
        default: return label.capitalized
        }
    }
}
