//
//  AddHospitalViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/13/21.
//

import Foundation
import Combine
import Resolver

struct AddHospitalRequestData: Codable {
    let companyIds: [Int]
    let hospitalName: String
    
    func toDict() -> [String: Any] {
        return ["companyIds": companyIds,
                "hospitalName": hospitalName
        ]
    }
}

class AddHospitalViewModel: ObservableObject {
    @Published var companies: [Company] = []
    @Published var companiesLoading = false
    @Published var addingHospital = false
    @Published var hospitalName = ""
    @Published var infoMessage: String?
    @Published var showAlert = false
    
    private var networkService: NetworkServiceProtocol;
    
    var selectedCompanyIds = Set<Int>()

    var cancellables = Set<AnyCancellable>()
   
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        
       $showAlert.sink {[weak self] show in
           if !show {
               self?.infoMessage = nil
           }
       }
       .store(in: &cancellables)
     //service.handle(obj: EmptyParam())
   }
   
    func check(id: Int) {
        selectedCompanyIds.insert(id)
    }
    
    func uncheck(id: Int) {
        selectedCompanyIds.remove(id)
    }
    

    
   func loadCompanies() {
       guard let url = URL(string: ApiUrls.companies()) else {
           return;
       }
       
       companiesLoading = true
       
       networkService.publisher(for: url, responseType: [Company].self, decoder: .init())
           .sink { [weak self] (completion) in
               switch completion {
               case .finished:
                   print("finished")
                   
               case .failure(let error):
                   print(error)
                   print("HATA OLDU")
                   
               }
               print("COMPLETION: \(completion)")
               self?.companiesLoading = false
   
           } receiveValue: {[weak self] comps in
               self?.companies = comps
           }
           .store(in: &cancellables)
   }
    
    
    func addHospital() {
        print(ApiUrls.addHospital())
        let requestBody = AddHospitalRequestData(companyIds: Array(selectedCompanyIds), hospitalName: hospitalName)
        guard let request = networkService.makeRequest(urlStr: ApiUrls.addHospital(), body: requestBody.toDict(), method: .post) else {
            return
        }
        
        addingHospital = true
        networkService.publisher(for: request, responseType: DemoMessage.self, decoder: .init())
            .sink { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("finished")
                
                case .failure(let error):
                    print(error)
                    print("Bir hata oldu")
                    self?.infoMessage = "Bir hata oldu"
                    self?.showAlert = true
                }
                print("COMPLETION: \(completion)")
                self?.addingHospital = false
                self?.showAlert = true
            } receiveValue: {[weak self] msg in
                print(msg.message)
                self?.infoMessage = msg.message
                // self?.showMessage = true
            }
            .store(in: &cancellables)
    }
}
