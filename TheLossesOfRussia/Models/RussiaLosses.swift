//
//  RussiaLosses.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//

import Foundation

enum RussiaLosses: String {
    
    case equipment = "russia_losses_equipment.json"
    case equipmentCorrection = "russia_losses_equipment_correction.json"
    case equipmentOryx = "russia_losses_equipment_oryx.json"
    case personnel = "russia_losses_personnel.json"
    
    func stringValue() -> String {
        return self.rawValue
    }
}
