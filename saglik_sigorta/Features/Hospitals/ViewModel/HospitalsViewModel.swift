//
//  HospitalsViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation
import Combine

class HospitalsViewModel: ObservableObject {
    var searched = false
    // TODO: inject dependency
    let pg: Pagination = Pagination<Hospital>()
    let companyId: Int
    // TODO: inject dependency
    let hospitalService: HospitalServiceProtocol = HospitalService()
    var cancellables = Set<AnyCancellable>()
    
    @Published var hospitals = [Hospital]()
    @Published var hospitalsLoading: Bool = false
    @Published var error: ApiError?
    @Published var notFound: Bool = false
    
    init(companyId: Int) {
        self.companyId = companyId
        loadMore()
    }
    
    func loadMore(currentItem: Hospital? = nil, name: String? = nil, insertMode: InsertMode = .append, warnNotFound: Bool = false) {
        if !pg.shouldLoadMoreData(currentItem: currentItem, items: hospitals) {
            return
        }
        pg.currentlyLoading = true
        
        hospitalService.fetchHospitals(for: companyId, page: pg.nextPageToLoad, name: name, completed: {
            result in self.responseCallback(result: result, insertMode: insertMode, warnNotFound: warnNotFound) }
        )
    }
    
    
    private func responseCallback(result: Result<[Hospital], ApiError>, insertMode: InsertMode, warnNotFound: Bool) {
        switch result {
        case .failure(let error):
            DispatchQueue.main.async {
                self.handleError(error: error)
                self.pg.currentlyLoading = false
            }
        case .success(let hospitals):
            DispatchQueue.main.async {
                if warnNotFound {
                    self.notFound = hospitals.isEmpty
                }
                switch insertMode {
                    case .append:
                        self.hospitals.append(contentsOf: hospitals)
                    case .assign:
                        self.hospitals = hospitals
                }
                self.pg.successfullyLoaded(itemsExhausted: hospitals.isEmpty)
            }
        }
    }
    
    private func handleError(error: ApiError) {
        self.error = error
    }
    
   
    func searchFor(name: String) -> Void {
        DispatchQueue.main.async {
            self.error = nil
        }
        self.searched = true
        guard !name.isEmpty else {
             _searchFor()
             self.searched = false
             return
        }
        _searchFor(name: name)
    }
    
    private func _searchFor(name: String? = nil) {
        pg.resetForNewRequest()
        loadMore(currentItem: nil, name: name, insertMode: .assign, warnNotFound: true)
    }
    
    
    
    func deleteHospital(offsets: IndexSet) {
        guard let willDeletedIndex = offsets.first else {
            return;
        }
        
        let willDeletedHospital = hospitals[willDeletedIndex]
        print(willDeletedHospital)
        
        guard let request = makeDenemeRequest(id: willDeletedHospital.id) else {
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
                    self?.hospitals.remove(atOffsets: offsets)
                case .failure(let error):
                    print("HATA OLDU")
                }
                print("COMPLETION: \(completion)")
    
            } receiveValue: {[weak self] msg in
                print(msg.message)
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
    
    
    private func makeDenemeRequest(id: Int) -> URLRequest? {
        guard let url = URL(string: ApiUrls.deleteHospital(id: id)) else {
            print("Error: cannot create URL")
            return nil
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        return request
    }
}



extension HospitalsViewModel: RandomAccessCollection {
    typealias Element = Hospital
    
    var startIndex: Int { hospitals.startIndex }
    var endIndex: Int { hospitals.endIndex }
    
    subscript(position: Int) -> Hospital {
        return hospitals[position]
    }
}
