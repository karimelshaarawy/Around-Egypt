//
//  ExperienceViewModel.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 27/10/2023.
//

import Foundation

struct ExperienceViewModel{

    var id: String
    var title: String
    var coverPhoto: String
    var description: String
    var noOfLikes: Int
    var recommended: Int
    var viewsNumber: Int
    var isLiked: Bool
    
    
    init(experience:Datum){
        id = experience.id ?? "0"
        title = experience.title ?? ""
        coverPhoto = experience.coverPhoto ?? ""
        description = experience.description ?? ""
        noOfLikes = experience.likesNo ?? 0
        recommended = experience.recommended ?? 0
        viewsNumber = experience.viewsNo ?? 0
        isLiked = false
    }
    
}


