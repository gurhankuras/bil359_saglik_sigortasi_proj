//
//  InsuranceCompaniesView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import Foundation


import Foundation
import SwiftUI

struct InsuranceCompaniesView : View {
    // TODO: Get companies from network call and move it into a service
    var body: some View {
        VStack {
            SearchBar()
            CompanyListView()
        }.padding(.bottom, 50)
    }
}


// TODO: Change the generic name more specific
struct SearchBar: View {
    var body: some View {
        HStack {
            SearchBox()
            Button("Ara", action: searchCompanyHandler)
        }
        .padding(.horizontal)
    }
    
    func searchCompanyHandler() -> Void {
        
    }
}

// TODO: Make this component more generic
struct SearchBox: View {
    @State var searchText: String = ""
    @FocusState private var searchFieldIsFocused: Bool
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Image(systemName: "magnifyingglass")
                .frame(maxHeight: 40)
                .padding(.horizontal, 8)
                .foregroundColor(
                    Color(.systemGray2))
                .onTapGesture {
                    searchFieldIsFocused = true
                }
            TextField("Şirket Arama", text: $searchText)
                .focused($searchFieldIsFocused)
        }
        .background(Color(.systemGray6))
        .clipShape(
            RoundedRectangle(cornerRadius: 10))
    }
}

struct CompanyListView: View {
    let companies : [InsuranceCompany] = InsuranceCompany.companies
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(companies) { company in
                    CompanyTileView(company: company)
                        .padding([.leading])
                }
            }
            .padding(.top)
            
        }
        .navigationTitle("Sigorta Şirketleri")
    }
}


struct InsuranceCompanies_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark).previewDevice("Iphone 11")
            
    }
}




