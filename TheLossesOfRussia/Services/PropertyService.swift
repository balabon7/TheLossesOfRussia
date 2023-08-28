//
//  PropertyService.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 28.08.2023.
//

import Foundation

class PropertyMapper {
    
    static func properties(for equipment: Equipment?) -> [(label: String, value: String?)] {
        let formattedDate = equipment?.date?.formatDate(from: "yyyy-MM-dd", to: "dd MMMM yyyy")
        
        let allProperties = [
            ("Date", formattedDate),
            ("Day", equipment?.day?.description),
            ("Aircraft", equipment?.aircraft?.description),
            ("Helicopter", equipment?.helicopter?.description),
            ("Tank", equipment?.tank?.description),
            ("APC", equipment?.apc?.description),
            ("Field Artillery", equipment?.fieldArtillery?.description),
            ("MRL", equipment?.mrl?.description),
            ("Military Auto", equipment?.militaryAuto?.description),
            ("Fuel Tank", equipment?.fuelTank?.description),
            ("Drone", equipment?.drone?.description),
            ("Naval Ship", equipment?.navalShip?.description),
            ("Anti Aircraft Warfare", equipment?.antiAircraftWarfare?.description),
            ("Special Equipment", equipment?.specialEquipment?.description),
            ("Mobile SRBM System", equipment?.mobileSRBMSystem?.description),
            ("Greatest Losses Direction", equipment?.greatestLossesDirection),
            ("Vehicles And Fuel Tanks", equipment?.vehiclesAndFuelTanks?.description),
            ("Cruise Missiles", equipment?.cruiseMissiles?.description)
        ]
        return allProperties.filter { $0.1 != nil }
    }
    
    static func properties(for equipmentOryx: EquipmentOryx?) -> [(label: String, value: String?)] {
        return [
            ("Equipment Oryx", equipmentOryx?.equipmentOryx?.description),
            ("Model", equipmentOryx?.model?.description),
            ("Manufacturer", equipmentOryx?.manufacturer?.rawValue),
            ("Losses Total", equipmentOryx?.lossesTotal?.description),
            ("Equipment Ua", equipmentOryx?.equipmentUa?.rawValue)
        ]
    }
    
    static func properties(for personnel: Personnel?) -> [(label: String, value: String?)] {
        return [
            ("Date", personnel?.date?.description),
            ("Day", personnel?.day?.description),
            ("Personnel", personnel?.personnel?.description),
            ("Personnel Details", personnel?.personnelDetails?.rawValue),
            ("POW", personnel?.pow?.description)
        ]
    }
}
