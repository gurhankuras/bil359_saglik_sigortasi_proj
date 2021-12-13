//
//  DoubleExtension.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/13/21.
//

import Foundation

extension Double {
    func toFixedString(_ places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
}
