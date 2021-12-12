//
//  TeklifAlView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/30/21.
//

import SwiftUI

struct TeklifAlView: View {
    @StateObject var vm: TeklifAlViewModel = TeklifAlViewModel()
    
    var body: some View {
        VStack {
            Section {
                SearchBox(searchText: $vm.age,
                          placeholder: "Yaşı Giriniz")
                SearchBox(searchText: $vm.hospitalInfo,
                          placeholder: "Hastane Bilgisini giriniz")
            }
            Button (action: searchHandler,
                    label: { TeklifAlViewButton(text: "Ara") })
            
            if vm.offerIsLoading {
                ProgressView()
            }
            else if !vm.errorMessage.isEmpty {
                ErrorView(message: vm.errorMessage)
            }
            else if vm.isOfferReady {
                TeklifAlViewDetails(offer: vm.offer!)
            }
            else {
                Spacer()
            }
            
        }
        .padding()
        .padding()
        .alert(vm.errorMessage, isPresented: $vm.showErrorMessage) {
            Button("Ok") {}
        }
        .navigationTitle("Teklif")
    }
    
    func searchHandler() {
        guard let (age, hospitalName) = vm.validateInputs() else { return }
        vm.loadOffer(age: age, hospitalInfo: hospitalName)
    }
}

struct TeklifAlView_Previews: PreviewProvider {
    static var previews: some View {
        TeklifAlView()
            .preferredColorScheme(.dark)
            
    }
}




struct TeklifAlViewDetails: View {
    let offer: Offer
    var body: some View {
        // Spacer()
        ScrollView {
            VStack {
                OfferDetailsTile(offer: offer)
                OfferDetailsTile(offer: offer)
                OfferDetailsTile(offer: offer)
                OfferDetailsTile(offer: offer)
                OfferDetailsTile(offer: offer)
                OfferDetailsTile(offer: offer)
                OfferDetailsTile(offer: offer)
                OfferDetailsTile(offer: offer)
            }            
        }
        // Spacer()
        // Spacer()
        /*
        NavigationLink(destination: TeklifSonucDetailsView(offer: offer),
                       label: {
            TeklifAlViewButton(text: "Teklif Al")
        })
         */
        
    }
}

struct TeklifAlViewButton: View {
    let text: String
    var body: some View {
        Text(text)
            .padding()
            .padding(.horizontal)
            .frame(maxWidth: 200)
            .background(.blue)
            .clipShape(Capsule())
            .foregroundColor(.white)
            .padding(5)
    }
}

