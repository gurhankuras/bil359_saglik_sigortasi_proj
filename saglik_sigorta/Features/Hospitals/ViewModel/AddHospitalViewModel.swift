//
//  AddHospitalViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/13/21.
//

import Foundation
import Combine


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
    
    var selectedCompanyIds = Set<Int>()
    
   var cancellables = Set<AnyCancellable>()
   
   init() {
       $showAlert.sink {[weak self] show in
           if !show {
               self?.infoMessage = nil
           }
       }
       loadCompanies()
   }
   
    func check(id: Int) {
        selectedCompanyIds.insert(id)
    }
    
    func uncheck(id: Int) {
        selectedCompanyIds.remove(id)
    }
    
   func loadCompanies() {
       guard let request = makeGetRequest(urlStr: ApiUrls.companies()) else {
           return
       }
       
       companiesLoading = true
       URLSession.shared.dataTaskPublisher(for: request)
           .receive(on: DispatchQueue.main)
           .tryMap(handleOutput(output:))
           .decode(type: [Company].self, decoder: JSONDecoder())
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
    
    func addHospital() {
        print(ApiUrls.addHospital())
        let requestBody = AddHospitalRequestData(companyIds: Array(selectedCompanyIds), hospitalName: hospitalName)
        guard let request = makePostRequest(urlStr: ApiUrls.addHospital(), body: requestBody.toDict()) else {
            return
        }
        
        addingHospital = true
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput(output:))
            .decode(type: DemoMessage.self, decoder: JSONDecoder())
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
        
        

        private func makePostRequest(urlStr: String, body: [String: Any]) -> URLRequest? {
            guard let url = URL(string: urlStr) else {
                print("Error: cannot create URL")
                return nil
            }
            
            print(body)
            let parameters = body
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
            
            print(request.httpBody)
            // Create the request
            return request
        }
}
