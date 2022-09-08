//
//  Encounter+Section.swift
//  Birdie
//
//  Created by Daniel Jilg on 08.09.22.
//

import Foundation

extension Encounter {
    @objc
    var section: String {
        guard let timestamp = self.timestamp else { return "unknown" }
        
        if Calendar.current.isDateInToday(timestamp) {
            return "today"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL YYYY"
        return dateFormatter.string(from: timestamp)
    }
}
