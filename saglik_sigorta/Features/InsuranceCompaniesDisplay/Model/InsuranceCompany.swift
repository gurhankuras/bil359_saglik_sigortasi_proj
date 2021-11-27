//
//  InsuranceCompany.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import Foundation


struct InsuranceCompany: Identifiable, Decodable{
    let id: String
    let name: String
    let image: String
    let affiliatedHospitals: [String]
    let ageGroup: String
    
    // TODO: find more reasonable default for error case
    var ageGroupRanged: ClosedRange<Int> {
        let splitted = ageGroup.components(separatedBy: "-")
        let start = Int(splitted[0]) ?? 0
        let end = Int(splitted[1]) ?? 0
        return start...end
    }
}


extension InsuranceCompany {
    /*
    static let exampleCompany = InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10")
    static let companies =  [
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: "1-10"),
    
    ]
     */
}
