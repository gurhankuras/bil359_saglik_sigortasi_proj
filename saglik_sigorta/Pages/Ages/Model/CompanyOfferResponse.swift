//
//  CompanyOfferResponse.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/13/21.
//

import Foundation

struct CompanyOffersResponse: Decodable, Identifiable {
    let id = UUID()
    let company: Company
    let ageOffers: [AgeOffer]
}

// MARK: - AgeOffer
struct AgeOffer: Decodable, Identifiable {
    let id = UUID()
    let ageStart, ageEnd: Int
    let price: Double?
    let previousValue: Double?
    
    var ageStr: String {
        return "\(ageStart)-\(ageEnd)"
    }
    
    var priceStr: String {
        return price != nil ? "\(price!)" : ""
    }
    
    var discountPercentage: String {
        return previousValue != nil && price != nil ? "%\(((1 - (price! / previousValue!)) * 100).rounded())" : ""
    }
    
    private enum CodingKeys : String, CodingKey {
        case ageStart="age_start", ageEnd="age_end", price, previousValue="previous_value"
    }
}

// MARK: - Company
struct OfferCompany: Decodable, Identifiable {
    let id: Int
    let companyName: String
    let image: String
    
    private enum CodingKeys : String, CodingKey {
        case id, companyName="company_name", image
    }
}
