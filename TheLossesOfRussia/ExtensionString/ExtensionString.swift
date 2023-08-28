//
//  ExtensionString.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 28.08.2023.
//

import Foundation

extension String {
    func formatDate(from inputFormat: String, to outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
}
