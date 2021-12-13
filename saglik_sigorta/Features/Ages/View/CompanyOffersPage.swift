//
//  InsuranceAgeGroupsView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import Foundation
import SwiftUI

struct AgePricing: Identifiable {
    let id: UUID = UUID()
    let ageStart: Int
    let ageEnd: Int
    let price: Double
    
    var ageString: String {
        if ageEnd == 999 {
            return "+65"
        }
        return "\(ageStart)-\(ageEnd)"
    }
}

struct CompanyOffersPage : View {
    let emptyStr = ""
    @StateObject var vm : AgeBasedOfferViewModel = AgeBasedOfferViewModel()
   
    var body: some View {
        VStack {
            /*
            SearchBar(searchText: $ageVM.searchText, placeholder: "Yaşınızı giriniz", actionText: "Ara") {
                guard let age = ageVM.validateAgeInput() else {
                    return
                }
                ageVM.getOffer(forAge: age)
            }
             */
            //ScrollView {
            List {
                ForEach(vm.offers) { companyOffer in
                    CompanyOfferAccordion(companyOffer: companyOffer)
                }.onDelete { indexSet in
                    vm.deleteCompany(offsets: indexSet)
                }
                
            }
                
                
            //}
        }
        .navigationTitle("Şirket Teklifi")
        /*
        .alert(ageVM.errorMessage, isPresented: $ageVM.showErrorMessage) {
            Button("Ok") {
                
            }
        }
         */
        .overlay(
            NavigationLink(destination: {
                AddOfferPage()
            }, label: {
                AddButton()
            })
                .tint(.white),
                alignment: .bottomTrailing
           
        )
    }
}



struct CompanyOffersPage_Previews: PreviewProvider {
    static var previews: some View {
        CompanyOffersPage().previewDevice("Iphone 11")
            .preferredColorScheme(.dark)
    }
}

struct CompanyOfferAccordion: View {
    let companyOffer: CompanyOffersResponse

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
       ]
    
    @State var isShowing = false
    
    var body: some View {
        VStack {
            HStack {
                CompanyLogo(url: companyOffer.company.image)
                Text(companyOffer.company.name)
                    .bold()
                Spacer()
                Image(systemName: "chevron.down")
            }
            
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                //withAnimation(.easeInOut) {
                    isShowing.toggle()
                //}
            }
            if isShowing {
                VStack {
                    Text("Yaş Grubu Teklifleri")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(companyOffer.ageOffers) { offer in
                            HStack {
                                Text("\(offer.ageStr)")
                                    .frame(width: 50, alignment: .leading)
                                Text(":")
                                Text(String(offer.price))
                                
                            }
                        }
                    }
                }
                .padding()
               
            }
        }
    }
}
