//
//  ExperienceViewModel.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 27/10/2023.
//

import Foundation

class ExperienceViewModel{

    var id: String
    var title: String
    var coverPhoto: String
    var description: String
    var noOfLikes: Int
    var recommended: Int
    var viewsNumber: Int
    var isLiked: Bool
    var address: String
    
    
    init(experience:Datum){
        id = experience.id ?? "0"
        title = experience.title ?? ""
        coverPhoto = experience.coverPhoto ?? ""
        description = experience.description ?? ""
        noOfLikes = experience.likesNo ?? 0
        recommended = experience.recommended ?? 0
        viewsNumber = experience.viewsNo ?? 0
        isLiked = false
        address = (experience.city?.name ?? "" ) + ", Egypt"
    }
    
    
    func addLike(reload:@escaping()->Void)->Void{
        if(isLiked == false){
            APIManager.postLikeRequest(id: id) {[weak self] likes, error in
                if(error == nil){
                    self?.isLiked = true
                    if let likes = likes{
                        self?.noOfLikes = likes
                        reload()
                    }
                    
                }
            }
        }
    }
    
    
}


