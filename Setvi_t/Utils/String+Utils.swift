//
//  Setvi_tApp.swift
//  Setvi_t
//
//  Created by Pavle on 01.05.24..
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension String {
    func toReadableDate() -> String? {
        
        let isoDateFormatter = DateFormatter()
        isoDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        isoDateFormatter.locale = .current
        isoDateFormatter.timeZone = .current
        
        guard let date = isoDateFormatter.date(from: self) else {
            return nil
        }
        
        let readableDateFormatter = DateFormatter()
        readableDateFormatter.dateStyle = .medium
        readableDateFormatter.timeStyle = .medium
        readableDateFormatter.locale = Locale.current
        
        return readableDateFormatter.string(from: date)
    }
}
