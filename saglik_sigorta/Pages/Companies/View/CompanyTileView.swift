//
//  CompanyTileView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import Foundation
import SwiftUI


struct CompanyTileView: View {
    let company: Company

    var body: some View {
        HStack {
            CompanyLogo(url: company.image)
            Text(company.name)
                .font(.caption)
                .lineLimit(1)
                .frame(width: 100, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        
            /*
            AgeGroupsButton(
                text: "Yaş Grupları",
                destination: {
                   CompanyOffersPage()
                }
            )
             */
            
            HospitalsButton(
                text: "Hastaneler",
                destination: {
                    HospitalsView(companyId: company.id)
                },
                icon: Image(systemName: "cross.fill").foregroundColor(.red)
            )
             
           
             
            
        }
        .padding(.trailing)
        .padding(.vertical)
        .padding(.vertical)
        .onAppear {
            // print(company.id)
        }
    }
}



struct CompanyLogo: View {
    let url: String
    var body: some View {
        /*
        Circle().frame(width: 50, height: 50)
            .foregroundColor(.blue)
        */
        
        
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
                .clipShape(Circle())
                .background(.white)
        } placeholder: {
            Color.blue
        }
        .frame(width: 50, height: 50)
        .clipShape(Circle())
    
         
         }
}



// TODO: Use base button. dont repeat
struct AgeGroupsButton<Destination: View> : View{
    let text: String
    let destination: () -> Destination
    
    var body: some View {
        NavigationLink(
            destination: LazyView(view: destination),
            label: {
                    Text(text)
                        .font(.caption)
                        .foregroundColor(Color("ReverseThemeColor"))
                        .padding(.vertical, 5)
                        .padding(.trailing, 5)
                        .padding(.leading, 3)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
            })
    }
}

struct HospitalsButton<Destination: View, Icon: View> : View{
    let text: String
    let destination: () -> Destination
    let icon: Icon
    
    var body: some View {
        NavigationLink(
            destination: LazyView(view: destination),
            label: {
                HStack(spacing: 0) {
                    icon
                    Text(text)
                        .lineLimit(2)
                        .truncationMode(.head)
                        .font(.caption)
                        .foregroundColor(Color("ReverseThemeColor"))
                        .padding(.vertical, 5)
                        .padding(.trailing, 5)
                        .padding(.leading, 3)
                        
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 5)
                .background(Color(.systemGray).opacity(0.5))
                
                .clipShape(RoundedRectangle(cornerRadius: 10))
               
                    
            })
          
    }
}

/*
struct CompanyTileView_Previews: PreviewProvider {
    static let exampleCompany = Company.exampleCompany
    
    static var previews: some View {
        
        Group {
            CompanyTileView(company: exampleCompany)
                .preferredColorScheme(.dark)
                .previewDevice("Iphone 11")
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewInterfaceOrientation(.landscapeLeft)
        }
        
        
        Group {
            CompanyTileView(company: exampleCompany)
                .preferredColorScheme(.light)
                .previewDevice("iPod touch (7th generatiion)")
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
*/
