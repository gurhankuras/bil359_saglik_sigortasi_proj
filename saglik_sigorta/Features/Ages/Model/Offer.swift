//
//  Offer.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/30/21.
//

import Foundation


struct Offer: Decodable, Identifiable {
    let id: Int
    let company: Company
    let ageStart: Int
    let ageEnd: Int
    let amount: Double
    let hospital: Hospital
    
    var age: Int?
    
    var ageStr: String {
        return age != nil ? "\(String(age!))" : "-"
    }

    var ageGroup: ClosedRange<Int> {
        return ageStart...ageEnd
    }
    
    var ageRangeText: String {
        return "\(ageStart)-\(ageEnd)"
    }
    
    private enum CodingKeys : String, CodingKey {
        case id, company, ageStart="age_start", ageEnd="age_end", amount="price", hospital
    }
}
