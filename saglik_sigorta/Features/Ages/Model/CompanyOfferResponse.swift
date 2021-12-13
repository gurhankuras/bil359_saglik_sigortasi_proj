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
    let price: Double
    
    var ageStr: String {
        return "\(ageStart)-\(ageEnd)"
    }
    
    private enum CodingKeys : String, CodingKey {
        case ageStart="age_start", ageEnd="age_end", price
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
