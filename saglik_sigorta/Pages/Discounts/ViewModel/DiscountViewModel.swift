//
//  DiscountViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 1/3/22.
//

import Foundation
import Combine

class DiscountViewModel: ObservableObject {
    @Published var offers: [CompanyOffersResponse] = []
    @Published var loading = true
    
    private let networkService: NetworkServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func loadDiscounts() {
         let request = networkService.makeRequest(urlStr: "http://localhost:3000/api/companies/discounts", body: nil, method: .get)
                
                loading = true
                
                networkService.publisher(for: request!, responseType: [String: CompanyOffersResponse].self, decoder: JSONDecoder())
                .map({ cmpMap in
                    return cmpMap.map { $1 }
                })
                .sink { [weak self] (completion) in
                    switch completion {
                    case .finished:
                        print("finished")
                        
                    case .failure(let error):
                        print(error)
                        print("HATA OLDU")
                    }
                    print("COMPLETION: \(completion)")
                    self?.loading = false
        
                } receiveValue: {[weak self] offers in
                    print(offers)
                    self?.offers = offers
                }
                .store(in: &cancellables)

    }
    /*
     
     
     func deleteCompany(offsets: IndexSet) {
         guard let willDeletedIndex = offsets.first else {
             return;
         }
         
         
         let willDeletedCompany = offers[willDeletedIndex].company
         print(willDeletedCompany)
         
         guard let request = makeDeleteRequest(id: willDeletedCompany.id) else {
             return
         }
         
         URLSession.shared.dataTaskPublisher(for: request)
             .receive(on: DispatchQueue.main)
             .tryMap(handleOutput(output:))
             .decode(type: DemoMessage.self, decoder: JSONDecoder())
             .sink { [weak self] (completion) in
                 switch completion {
                 case .finished:
                     print("finished")
                     self?.offers.remove(atOffsets: offsets)
                 case .failure(let error):
                     print("HATA OLDU")
                 }
                 print("COMPLETION: \(completion)")
     
             } receiveValue: {[weak self] msg in
                 print(msg.message)
             }
             .store(in: &cancellables)
         
     }
     */
    
    func deleteDiscounts(offsets: IndexSet) {
        guard let willDeletedIndex = offsets.first else {
            return;
        }
        
        
        let willDeletedCompany = offers[willDeletedIndex].company
        print(willDeletedCompany)
        let request = networkService.makeRequest(urlStr: "http://localhost:3000/api/companies/\(willDeletedCompany.id)/discounts", body: nil, method: .delete)
        networkService.publisher(for: request!, responseType: DemoMessage.self, decoder: JSONDecoder())
            .sink { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("finished")
                    
                case .failure(let error):
                    print(error)
                    print("HATA OLDU")
                }
                print("COMPLETION: \(completion)")
    
            } receiveValue: {[weak self] offers in
                self?.offers.remove(atOffsets: offsets)
            }
            .store(in: &cancellables)
    }
}
