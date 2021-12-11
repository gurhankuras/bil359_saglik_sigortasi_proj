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
    @StateObject var ageVM : AgeBasedOfferViewModel = AgeBasedOfferViewModel()
   
    var body: some View {
        VStack {
            SearchBar(searchText: $ageVM.searchText, placeholder: "Yaşınızı giriniz", actionText: "Ara") {
                guard let age = ageVM.validateAgeInput() else {
                    return
                }
                ageVM.getOffer(forAge: age)
            }
            //ScrollView {
            List {
                ForEach(1..<10, id: \.self) { index in
                    
                    CompanyOfferAccordion()
                    
                }.onDelete { indexSet in
                    
                }
                
            }
                
                
            //}
        }
        .navigationTitle("Şirket Teklifi")
        .alert(ageVM.errorMessage, isPresented: $ageVM.showErrorMessage) {
            Button("Ok") {
                
            }
        }
        .overlay(
            NavigationLink(destination: {
                Text("sadasd")
            }, label: {
                AddButton()
            })
                .tint(.white)
                    ,
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
    
    let prices = [
        AgePricing(ageStart: 0, ageEnd: 9, price: 300.0),
        AgePricing(ageStart: 10, ageEnd: 18, price: 300.0),
        AgePricing(ageStart: 19, ageEnd: 25, price: 300.0),
        AgePricing(ageStart: 26, ageEnd: 50, price: 300.0),
        AgePricing(ageStart: 65, ageEnd: 999, price: 300.0),
    ]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
       ]
    
    @State var isShowing = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Axa Sigorta")
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
                        ForEach(prices) { p in
                            HStack {
                                Text("\(p.ageString)")
                                    .frame(width: 50, alignment: .leading)
                                Text(":")
                                Text(String(p.price))
                                
                            }
                        }
                    }
                }
                .padding()
               
            }
        }
    }
}
