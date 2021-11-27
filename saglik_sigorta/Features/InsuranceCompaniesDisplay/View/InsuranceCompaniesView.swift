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
    @State var searchText: String = ""
    
    @EnvironmentObject var companyViewModel: InsuranceCompaniesViewModel

    // TODO: Get companies from network call and move it into a service
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText,
                      placeholder: "Şirket Arama",
                      actionText: "Ara",
                      searchAction: searchCompanyHandler)
            InsuranceCompaniesBodyView()
            
        }.padding(.bottom, 50)
            .navigationTitle("Sigorta Şirketleri")
    }
    
    func searchCompanyHandler() -> Void {
        
    }
}

struct InsuranceCompaniesBodyView: View {
    @EnvironmentObject var companyViewModel: InsuranceCompaniesViewModel

    var body: some View {
        if (companyViewModel.error != nil) {
            ErrorView(message: companyViewModel.error?.rawValue)
        }
        else if (companyViewModel.companiesLoading) {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        } else {
            CompanyListView()
        }
    }
}


// TODO: Change the generic name more specific
struct SearchBar: View {
    @Binding var searchText: String
    let placeholder: String
    let actionText: String

    let searchAction: () -> Void
    
    var body: some View {
        HStack {
            SearchBox(searchText: $searchText, placeholder: placeholder)
            Button(actionText, action: searchAction)
        }
        .padding(.horizontal)
    }
}

// TODO: Make this component more generic
struct SearchBox: View {
    @Binding var searchText: String
    @FocusState private var searchFieldIsFocused: Bool

    let placeholder: String
    
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
            TextField(placeholder, text: $searchText)
                .focused($searchFieldIsFocused)
        }
        .background(Color(.systemGray6))
        .clipShape(
            RoundedRectangle(cornerRadius: 10))
    }
}

struct CompanyListView: View {
    @EnvironmentObject var companyViewModel: InsuranceCompaniesViewModel

    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(companyViewModel.remoteCompanies) { company in
                    CompanyTileView(company: company)
                        .padding([.leading])
                }
            }
            .padding(.top)
           // .onAppear {
            //    viewModel.fetchCompanies()
            //}
        }
       
    }
}


struct InsuranceCompanies_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark).previewDevice("Iphone 11")
            
    }
}






