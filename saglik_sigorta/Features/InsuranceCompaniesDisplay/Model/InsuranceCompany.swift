//
//  InsuranceCompany.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import Foundation


struct InsuranceCompany: Identifiable{
    let id: UUID = UUID()
    let name: String
    let image: String
    let affiliatedHospitals: [String]
    let ageGroup: ClosedRange<Int>
}


extension InsuranceCompany {
    
    static let exampleCompany = InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90)
    static let companies =  [
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
        InsuranceCompany(name: "Ak Sigorta", image: "https://www.hesapkurdu.com/Assets/img/insurer/3.png", affiliatedHospitals: ["Yavuz Hastanesi"], ageGroup: 1...90),
    
    ]
}
