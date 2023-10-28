//
//  ExperienceMainPage.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 28/10/2023.
//

import SwiftUI
import Kingfisher

struct ExperienceMainPage: View {
    var experience: ExperienceViewModel
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 15){ ZStack{ KFImage(URL(string: experience.coverPhoto)).resizable()
                .frame(width: geometry.size.width,height: 285)
                Image("images")
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 25, height: 20)
                               .offset(x: geometry.size.width/2 - 40, y: 100)
                Image("eye")
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 25, height: 20)
                               .offset(x: -geometry.size.width/2 + 40, y: 100)
                Text("\(experience.viewsNumber)")
                    .offset(x: -geometry.size.width/2 + 80, y: 100).foregroundColor(.white).font(.custom("gotham", size: 14))
            }
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Text(experience.title).fontWeight(.black)
                    
                        Text(experience.address)
                    }.font(.custom("gotham", size: 16))
                    Spacer()
                    Button (action:
                        {
                            print("Button")
                    }){
                        Image("share")
                    }
                    Button (action:
                        {
                            print("Button")
                    }){
                        Image( experience.isLiked ?
                               "like" : "unlike")
                    }
                    Text("\(experience.noOfLikes)").font(.custom("gotham", size: 16))

                }.padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                Divider()
                Text("Description").padding(20).font(.custom("gotham", size: 22))
                Text(experience.description).padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20)).font(.custom("gotham", size: 14))
                    
            }
            
        }
        
    }
}

struct ExperienceMainPage_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceMainPage(experience: ExperienceViewModel(experience: Datum(id: "lolo", title: "Nubian House", coverPhoto: "dummy pic", description: "lorem", viewsNo: 155, likesNo: 420, recommended: 1, hasVideo: 0, tags: [], city: City(id: 0, name: "Aswan", topPick: 0), tourHTML: "", famousFigure: "", period: nil, era: nil, founded: nil, detailedDescription: "lorem lorem", address: "Aswan,Egypt", gmapLocation: nil, startingPrice: nil, ticketPrices: nil, rating: nil, reviewsNo: nil, audioURL: nil, hasAudio: nil)))
    }
}
