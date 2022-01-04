//
//  Company.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import Foundation


struct Company: Identifiable, Decodable{
    let id: Int
    let name: String
    let image: String
    // let affiliatedHospitals: [String]?
    
    private enum CodingKeys : String, CodingKey {
        case id, name="company_name", image
        //, affiliatedHospitals="hospitals"
    }
}
