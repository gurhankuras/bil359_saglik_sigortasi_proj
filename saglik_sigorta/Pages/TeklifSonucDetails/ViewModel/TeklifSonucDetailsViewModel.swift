//
//  TeklifSonucDetailsViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/13/21.
//

import Foundation
import Combine
import Resolver

class TeklifSonucDetailsViewModel: ObservableObject {
    @Published var hospital: Hospital? = nil
    @Published var loading = true
    
    private var networkService: NetworkServiceProtocol
    
    let hospitalId: Int
    var cancellables = Set<AnyCancellable>()
    
    init(hospitalId: Int, networkService: NetworkServiceProtocol) {
        self.hospitalId = hospitalId
        self.networkService = networkService
        loadHospital()
    }
    
    func loadHospital() {
        guard let url = URL(string: ApiUrls.hospital(id: hospitalId)) else {
            return
        }
        
        loading = true
        
        networkService.publisher(for: url, responseType: Hospital.self, decoder: JSONDecoder())
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("finished")
                    
                case .failure(let error):
                    print(error)
                    print("HATA OLDU")
                    
                }
                print("COMPLETION: \(completion)")
                self?.loading = false
            } receiveValue: {[weak self] hospital in
                self?.hospital = hospital
            }
            .store(in: &cancellables)
    }
}
