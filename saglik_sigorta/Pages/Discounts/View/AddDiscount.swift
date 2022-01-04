//
//  AddDiscount.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 1/3/22.
//

import SwiftUI

struct AddDiscount: View {
    @StateObject var vm: AddDiscountViewModel = AddDiscountViewModel(networkService: NetworkService())
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            LabeledTextField(label: "Şirket Adı", text: $vm.companyName)
            LabeledTextField(label: "Başlangıç Yaşı", text: $vm.ageStart)
            LabeledTextField(label: "Bitiş Yaşı", text: $vm.ageEnd)
            LabeledTextField(label: "Uygulanacak İndirim Oranı", text: $vm.discountPercent)
                .padding(.bottom)
            if (!vm.errorMessage.isEmpty) {
                Text(vm.errorMessage)
                    .foregroundColor(.red)
                    .bold()
            }
            if vm.price != nil {
                VStack(alignment: .leading) {
                    Text("Güncel Fiyat:  $\(vm.constantPrice!)")
                    Text("İndirimli Fiyat: $\(vm.price!)")
                }
            }
                
            Spacer()
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    
                    Text("İptal")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            .red.opacity(0.8)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                .tint(.white)
                
                Button {
                    vm.addDiscount()
                    //vm.addOffer()
                    // dismiss()
                } label: {
                    
                    Text("Ekle")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            .green.opacity(0.8)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                .tint(.white)
                

            }
            
        }
        .padding()
        .padding(.horizontal)
        
        .alert(vm.displayer.message ?? "", isPresented: $vm.displayer.show) {
            Button {
                if !vm.hasError {
                    dismiss()
                }
                vm.hasError = false
            } label: {
                Text("Tamam")
            }

        }
         
    }
}

struct AddDiscount_Previews: PreviewProvider {
    static var previews: some View {
        AddDiscount()
    }
}
