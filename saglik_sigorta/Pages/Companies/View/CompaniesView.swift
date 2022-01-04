//
//  InsuranceCompaniesView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import Foundation


import Foundation
import SwiftUI

struct CompaniesView : View {
    @State var searchText: String = ""
    
    @EnvironmentObject var companyViewModel: CompaniesViewModel

    // TODO: Get companies from network call and move it into a service
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText,
                      placeholder: "Şirket Arama",
                      actionText: "Ara",
                      searchAction: searchCompanyHandler)
            CompaniesBodyView()
            
        }
     
        .padding(.bottom, 50)
            .navigationTitle("Sigorta Şirketleri")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink("İndirimler") {
                        DiscountsView()
                    }
                                    }
                            }            .alert("Bulunamadı", isPresented: $companyViewModel.notFound) {
                Text("Tamam")
            }
        
            .overlay(
                NavigationLink(destination: {
                    AddCompanyPage()
                }, label: {
                    AddButton()
                })
                    .tint(.white)
                        ,
                    alignment: .bottomTrailing
               
            )
    }
    
    func searchCompanyHandler() -> Void {
        print("CLICKED SEARCH BUTTON")
        companyViewModel.searchFor(name: searchText)
        //Task.init {
         //   await companyViewModel.searchCompany(searchText)
       // }
    }
}

struct CompaniesBodyView: View {
    @EnvironmentObject var companyViewModel: CompaniesViewModel

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
                .disableAutocorrection(true)
                .focused($searchFieldIsFocused)
        }
        .background(Color(.systemGray6))
        .clipShape(
            RoundedRectangle(cornerRadius: 10))
    }
}

struct CompanyListView: View {
    @EnvironmentObject var companyViewModel: CompaniesViewModel

    
    var body: some View {
        List {
            //LazyVStack {
            ForEach(companyViewModel.companies) { company in
                    CompanyTileView(company: company)
                        .padding([.leading])
                        
                        .onAppear {
                            if !companyViewModel.searched {
                                companyViewModel.loadMore(currentItem: company)
                            }
                        }
                        
                }
                .onDelete(perform: companyViewModel.deleteCompany(offsets:))
            //}
        }.listStyle(PlainListStyle())
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        CompanyOffersPage()
                    } label: {
                        Text("Şirket Teklifleri")
                            .foregroundColor(.blue)
                    }

                }
            }
        
        //.padding(.top)
       
    }
        
}


struct CompaniesView_Previews: PreviewProvider {
    static var previews: some View {
        CompaniesView().preferredColorScheme(.dark).previewDevice("Iphone 11")
            
    }
}






