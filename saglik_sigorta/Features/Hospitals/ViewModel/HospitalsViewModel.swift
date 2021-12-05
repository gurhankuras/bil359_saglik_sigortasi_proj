//
//  HospitalsViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation


class HospitalsViewModel: ObservableObject, RandomAccessCollection {
    // TODO: inject dependency
    /*
    let hospitalService: HospitalServiceProtocol = HospitalService()
    
    @Published var hospitals: [Hospital] = []
    @Published var hospitalsLoading: Bool = false
    @Published var error: ApiError?
    @Published var filteredHospitals: [Hospital] = []
    @Published var showSearchResults: Bool = false
    
    func loadHospitals(companyId: String) {
        hospitalsLoading = true
        hospitalService.fetchHospitals(for: companyId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let hospitals):
                DispatchQueue.main.async {
                    self.hospitals = hospitals
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                }
            }
            DispatchQueue.main.async {
                self.hospitalsLoading = false
            }
        }
    }
    
    func searchHospital(_ name: String) {
        guard !name.isEmpty else {
            showSearchResults = false
            print("burada")
            return;
        }
        
        filteredHospitals = hospitals.filter { hospital in
            return hospital.name == name
        }
        showSearchResults = true
    }
     
     */
    
    
    
    typealias Element = Hospital
    
    let companyId: String
    var startIndex: Int { hospitals.startIndex }
    var endIndex: Int { hospitals.endIndex }
    
    var nextPageToLoad: Int = 1
    var currentlyLoading: Bool = false
    var allItemsLoaded = false
    
    subscript(position: Int) -> Hospital {
        return hospitals[position]
    }
    
    let hospitalService: HospitalServiceProtocol = HospitalService()
    @Published var hospitals = [Hospital]()
    @Published var hospitalsLoading: Bool = false
    @Published var error: ApiError?
    
    init(companyId: String) {
        self.companyId = companyId
         loadMore()
    }
    
   
    enum InsertMode {
        case append, assign
    }
    
    func loadMore(currentItem: Hospital? = nil, name: String? = nil, insertMode: InsertMode = .append) {
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        currentlyLoading = true
       
        hospitalService.fetchHospitals(for: companyId, page: nextPageToLoad, name: name) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                }
            case .success(let hospitals):
                DispatchQueue.main.async {
                    switch insertMode {
                    case .append:
                        self.hospitals.append(contentsOf: hospitals)
                    case .assign:
                        self.hospitals = hospitals
                    }
                    self.nextPageToLoad += 1
                    self.currentlyLoading = false
                    self.allItemsLoaded = (hospitals.isEmpty)
                }
            }
        }
    }
    
        

     
    
    func shouldLoadMoreData(currentItem: Hospital? = nil) -> Bool {
        if allItemsLoaded {
            return false
        }
        if currentlyLoading {
            return false
        }
        guard let currentItem = currentItem else {
            return true
        }
        
        guard let lastItem = hospitals.last else {
            return true
        }
        
        return currentItem.id == lastItem.id
    }
    
    

                                          /*
    func fetchHospitals(page: Int, name: String? = nil) async -> Void {
        if (currentlyLoading) {
            return
        }
        
        DispatchQueue.main.async {
            self.hospitalsLoading = true
        }
        do {
            let companies = try await hospitalService.fetchCompanies(page: page, name: name)
            DispatchQueue.main.async {
                self.companies = companies
            }
        }
        catch {
            DispatchQueue.main.async {
                print(error)
                self.error = (error as? ApiError) ?? .error
            }
        }
        DispatchQueue.main.async {
            self.companiesLoading = false
        }
    }
                                           */
    
    func searchCompany(_ name: String) -> Void {
        DispatchQueue.main.async {
            self.error = nil
        }
        guard !name.isEmpty else {
            // showSearchResults = false
            // return;
             self.nextPageToLoad = 1
             self.allItemsLoaded = false
             loadMore(currentItem: nil, name: nil, insertMode: .assign)
            return
        }
         self.nextPageToLoad = 1
        self.allItemsLoaded = false
         loadMore(currentItem: nil, name: name, insertMode: .assign)
        
    }
}
