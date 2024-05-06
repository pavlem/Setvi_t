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
        // Create a DateFormatter to parse the ISO 8601 date string
        let isoDateFormatter = DateFormatter()
        isoDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        isoDateFormatter.locale = .current
        isoDateFormatter.timeZone = .current

        // Parse the date string
        guard let date = isoDateFormatter.date(from: self) else {
            return nil  // Return nil if the date string cannot be parsed
        }

        // Create another DateFormatter to format the date into a readable form
        let readableDateFormatter = DateFormatter()
        readableDateFormatter.dateStyle = .medium
        readableDateFormatter.timeStyle = .medium
        readableDateFormatter.locale = Locale.current  // Adapts to the user's current locale

        // Format the date into a readable string
        return readableDateFormatter.string(from: date)
    }
}
