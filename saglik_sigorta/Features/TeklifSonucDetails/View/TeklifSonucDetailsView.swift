//
//  TeklifSonucDetailsView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/30/21.
//

import SwiftUI

struct TeklifSonucDetailsView: View {
    @StateObject var vm: TeklifSonucDetailsViewModel
    init(offer: Offer) {
        self.offer = offer
        
        _vm = StateObject(wrappedValue: TeklifSonucDetailsViewModel(hospitalId:offer.hospitalId))
    }
    let offer: Offer
    var body: some View {
        ScrollView {
            if vm.loading {
                ProgressView()
            }
            else {
                
                VStack(alignment: .leading) {
                    HStack {
                        //Circle()
                        // .frame(width: 75, height: 75)
                        CompanyLogo(url: offer.company.image).frame(width: 75, height: 75)
                        // Spacer()
                        Text(offer.company.name)
                            .padding()
                    }
                    .padding(.vertical, 10)
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 7) {
                            Text("Hastane Adı: ")
                                .bold()
                            Divider()
                            Text("Fiyat: ")
                                .bold()
               
                    
                            Divider()
                            Text("Yaş Grubu Tarifesi: ")
                                .bold()
                                .multilineTextAlignment(.leading)
                            Divider()
                            Text("Hastane Adresi: ")
                                .bold()
                        }
                        Spacer()
                        VStack(alignment: .leading,  spacing: 7) {
                            Text(vm.hospital?.name ?? "-")
                            Divider()
                            Text("\(offer.amount) TL")
                            Divider()
                            Text(offer.ageRangeText)
                    
                            Divider()
                            Text(vm.hospital?.address.string ?? "-")
                        }
                        
                    }
                    
                }
                .frame(maxWidth: 400)
                .padding()
            }
        }
        .navigationTitle("Teklif Sonucu")
        
        
        
    }
}

struct TeklifSonucDetailsView_Previews: PreviewProvider {
    static let offer = Offer(
        id: 2,
        company: Company(id: 5, name: "Ak Sigorta", image: "sadasd"),
        ageStart: 10,
        ageEnd: 21,
                             //age: 20,
                             amount: 456,
                             hospitalId: 3
                                      
          )
    static var previews: some View {
        TeklifSonucDetailsView(offer: offer)
            .preferredColorScheme(.dark)
    }
}
