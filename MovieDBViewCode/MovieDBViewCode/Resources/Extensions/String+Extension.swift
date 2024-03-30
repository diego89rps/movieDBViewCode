//
//  String+Extension.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 29/03/24.
//

import Foundation

extension String {
    func formattedDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let data = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: data)
        } else {
            return nil
        }
    }
}
