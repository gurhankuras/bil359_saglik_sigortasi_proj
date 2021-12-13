//
//  TeklifSonucDetailsViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/13/21.
//

import Foundation
import Combine

class TeklifSonucDetailsViewModel: ObservableObject {
    @Published var hospital: Hospital? = nil
    @Published var loading = true

    let hospitalId: Int
    var cancellables = Set<AnyCancellable>()
    
    init(hospitalId: Int) {
        self.hospitalId = hospitalId
        loadHospital()
    }
    
    func loadHospital() {
        guard let request = makeGetRequest(urlStr: ApiUrls.hospital(id: hospitalId)) else {
            return
        }
        
        loading = true
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput(output:))
            .decode(type: Hospital.self, decoder: JSONDecoder())
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
    
            } receiveValue: {[weak self] hos in
                self?.hospital = hos
            }
            .store(in: &cancellables)
    }
     
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        let (data, response) = output;
        guard let response = response as? HTTPURLResponse,
              response.isGoodStatusCode else {
                  throw URLError(.badServerResponse)
              }
        return data
    }
    

    private func makeGetRequest(urlStr: String) -> URLRequest? {
        guard let url = URL(string: urlStr) else {
            print("Error: cannot create URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the request
        return request
    }
     
}
