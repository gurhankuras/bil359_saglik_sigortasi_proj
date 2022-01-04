//
//  Hospital.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation

struct Hospital: Identifiable, Decodable {
    let id: Int
    let name: String
    let address: Address
    
    private enum CodingKeys : String, CodingKey {
        case id, name="hospital_name", address
    }
}

struct Address: Decodable {
    let il: String?
    let ilce: String?
    let mahalle: String?
    let sokak: String?
    let no: Int?
    
    
    var ilStr: String {
        return il ?? "-"
    }
    var ilceStr: String {
        return ilce ?? "-"
    }
    var mahalleStr: String {
        return mahalle ?? "-"
    }
    var sokakStr: String {
        return sokak ?? "-"
    }
    var noStr: String {
        return no == nil ?  "-" : String(no!)
    }
    
    var string: String {
        return "\(mahalleStr) \(sokakStr) \(noStr) \(ilceStr) \(ilStr)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case il, ilce, mahalle, sokak, no="address_no"
    }
}
